package agent;

import CodinGame.printErr;
import agent.TActionType;
import game.Board;
import game.Config;
import game.Constants;
import game.Player;
import game.Tree;
import haxe.ds.ArraySort;

using Lambda;
using xa3.ArrayUtils;
using xa3.format.NumberFormat;

class Agent7 extends Agent {

	var startupStep = 0;
	final startupActions = [Grow, Grow, Seed, Grow, Seed, Grow, Grow, Grow];

	final mySeeds:Array<Int>  = [];
	final myTrees1:Array<Int>  = [];
	final myTrees2:Array<Int>  = [];
	final myTrees3:Array<Int>  = [];
	
	var seedCost:Int;
	var completeCost:Int;
	
	// final incomeProgress = [];
	var myAvgIncome = 2.0;
	var oppAvgIncome = 2.0;

	var state:TState;

	public function new( me:Player, opp:Player, board:Board ) {
		super( me, opp, board );
		state = Expansion;
	}

	override function takeAction() {
		if( day == 11 && state == Expansion ) state = Sustain;
		if( day == 18 && state == Sustain ) state = Contraction;

		myTrees.clear();
		oppTrees.clear();
		mySeeds.splice( 0, mySeeds.length );
		myTrees1.splice( 0, myTrees1.length );
		myTrees2.splice( 0, myTrees2.length );
		myTrees3.splice( 0, myTrees3.length );

		for( index => tree in trees ) {
			if( tree.owner.index == me.index ) {
				myTrees.set( index, tree );
				switch tree.size {
				case 0: mySeeds.push( index );
				case 1: myTrees1.push( index );
				case 2: myTrees2.push( index );
				case 3: myTrees3.push( index );
				}
			} else {
				oppTrees.set( index, tree );
			}
		}
		// final myTreeIndices = [for( index in myTrees.keys()) index].join(" ");
		// printErr( possibleActions );
		
		parsePossibleActions( possibleActions );
		var seedCost = getSeedCost( me );
		var t1Cost = getCostFor( 1, me );
		var t2Cost = getCostFor( 2, me );
		var t3Cost = getCostFor( 3, me );
		final growCosts = [t1Cost, t2Cost, t3Cost ];
		var completeCost = Constants.LIFECYCLE_END_COST;
		
		final myIncome = getIncome( myTrees );
		final oppIncome = getIncome( oppTrees );
		myAvgIncome = getAvgIncome( myTrees );
		oppAvgIncome = getAvgIncome( oppTrees );
		printErr( 'day $day  myIncome $myIncome (${myAvgIncome.fixed( 2 )})  oppIncome $oppIncome (${oppAvgIncome.fixed( 2 )})' );

		// printErr( 'day $day sun ${me.sun}' );
		final treeInfo = [for( index => tree in myTrees ) '$index T${tree.size}' ].join( "   " );
		// printErr( treeInfo );

		final actionType = startupStep < startupActions.length
			? startupActions[startupStep]
			: getActionType( seedCost, growCosts, completeCost, myAvgIncome );
		
		// printErr( '${startupStep < startupActions.length ? "s" :""} actionType $actionType income $income' );
		
		switch actionType {
			case Grow:
				if( growActions.length == 0 ) return "WAIT";
				final treeId = selectGrowAction( growCosts );
				final treeSize = trees[treeId].size;
				final cost = growCosts[treeSize];
				// trace( 'grow costs $growCosts' );
				if( me.sun >= cost ) {
					startupStep++;
					return 'GROW ${treeId}';
				} else return "WAIT";
			
			case Seed:
				if( seedActions.length == 0 || me.sun < seedCost ) return "WAIT";	
				final seedAction = selectSeedAction();
 				startupStep++;
				return 'SEED ${seedAction[0]} ${seedAction[1]}';
				
			case Complete( id ):
				if( completeActions.length == 0 || me.sun < completeCost ) return "WAIT";
				// sortCompleteAction( completeActions );
				// final richnesses = [for( cellId in completeActions ) '$cellId richness ${board.map[board.coords[cellId].s].richness}'];
				// trace( richnesses.join("\n"));
				startupStep++;
				return 'COMPLETE $id';
				
				
			case Wait: return "WAIT";
		}
	}

	function getActionType( seedCost:Int, growCosts:Array<Int>, completeCost:Int, income:Float ) {
		
		if( state != Contraction && seedActions.length > 0 && seedCost == 0 ) return Seed;
		// if( state == Expansion && seedActions.length > 0 && seedCost == 0 ) return Seed;
		// printErr( 'day $day sun ${me.sun} costs t1 ${growCosts[0]} t2 ${growCosts[1]} t3 ${growCosts[2]} trees t1 ${myTrees1.length} t2 ${myTrees2.length} t3 ${myTrees3.length}' );	
		if( state == Expansion ) return Grow;
		
		if( myTrees3.length > 0 ) {
			final incomesWithoutTree = myTrees3.map( treeId -> getIncomeWithout( treeId, myTrees ));
			final losses = incomesWithoutTree.map( incomeWithout -> income - incomeWithout );
			// final lossOutput = [for( i in 0...myTrees3.length ) 'without tree ${myTrees3[i]} loss ${losses[i]}'];
			// trace( 'state $state income $income - ' + lossOutput.join("  "));
			
			final lowestLossIndex = losses.minIndex();
			final lowestLoss = losses[lowestLossIndex];
			final remainingIncome = income - lowestLoss;

			switch state {
				case Expansion: // no-op
				case Sustain: if( remainingIncome > 15 ) return Complete( myTrees3[lowestLossIndex] );
				case Contraction: return Complete( myTrees3[lowestLossIndex] );
					// final remainingDays = Config.MAX_ROUNDS - day;
					// if( myTrees3.length >= remainingDays ) return Complete( myTrees3[lowestLossIndex] );
			}
			
		}
		
		return Grow;
	}
	
	function selectGrowAction( growCosts:Array<Int> ) {
		final cellRatings = growActions.map( treeId -> rateGrowCell( treeId, growCosts ));
		final highestRatingId = cellRatings.maxIndex();
		// traceGrowActions( growActions, cellRatings );
		return growActions[highestRatingId];
	}
	
	function rateGrowCell( treeId:Int, growCosts:Array<Int> ) {
		final tree = trees[treeId];
		final cost = growCosts[tree.size];
		final nextIncome = getIncomeWithGrown( treeId, myTrees );
		final sunPerCost = nextIncome / cost;
		final richness = board.cells[treeId].richness;

		final t3Bonus = state != Expansion && tree.size == 2 ? day * 0.5 : 0;
		// printErr( 'rateGrowCell $treeId: dIncome ${nextIncome - income}  richness $richness  cost ${sunPerCost.fixed( 2 )}  t3Bonus ${t3Bonus.fixed( 2 )}' );
		return sunPerCost + t3Bonus + richness * 0.1;
	}

	function traceGrowActions( growActions:Array<Int>, cellRatings:Array<Float> ) {
		final combined = [for( i in 0...growActions.length ) { rating: cellRatings[i], index: growActions[i]}];
		combined.sort(( a, b ) -> {
			if( a.rating < b.rating ) return -1;
			if( a.rating > b.rating ) return 1;
			return 0;
		});
		for( c in combined ) printErr( 'grow ${c.index} size ${trees[c.index].size}: ${c.rating}' );
	}

	function selectSeedAction() {
		final cellRatings = seedActions.map( rateSeedCell );
		final highestRatingId = cellRatings.maxIndex();
		// traceSeedActions( seedActions, cellRatings );
		return seedActions[highestRatingId];
	}

	function rateSeedCell( seedAction:Array<Int> ) {
		final sourceId = seedAction[0];
		final targetId = seedAction[1];
		final avgSun = 1 - getAverageShadowOfIndex( targetId, 0 );
		final distance = board.coords[sourceId].distanceTo( board.coords[targetId] );
		final richness = board.cells[targetId].richness;
		
		return avgSun * 2 + distance + richness * 0.1;
	}
	
	function traceSeedActions( seedActions:Array<Array<Int>>, cellRatings:Array<Float> ) {
		final combined = [for( i in 0...seedActions.length ) { rating: cellRatings[i], action: seedActions[i]}];
		combined.sort(( a, b ) -> {
			if( a.rating < b.rating ) return -1;
			if( a.rating > b.rating ) return 1;
			return 0;
		});
		for( c in combined ) printErr( 'seed ${c.action[0]} to ${c.action[1]}: ${c.rating}' );
	}

	function getAverageLoss( cellId:Int ) {
		final avgSun = 1 - getAverageShadowOfIndex( cellId, 3 );
		return avgSun * 3;
	}

	function getIncomeWithout( withoutTreeId:Int, trees:Map<Int, Tree> ) {
		var sum = 0.0;
		for( index => tree in trees ) {
			if( index != withoutTreeId ) {
				final avgShadow = getAverageShadowOfIndex( index, tree.size );
				sum += ( 1 - avgShadow ) * tree.size;
			}
		}
		// printErr( 'incomeWithout $withoutTreeId $sum' );
		return sum;
	}

	function getIncomeWithGrown( growTreeId:Int, trees:Map<Int, Tree> ) {
		var sum = 0.0;
		for( index => tree in trees ) {
			final size = index == growTreeId ? tree.size + 1 : tree.size;
			final avgShadow = getAverageShadowOfIndex( index, size );
			// final avgShadow = getAverageWeightedShadowOfIndex( index, size );
			sum += ( 1 - avgShadow ) * size;
		}
		// printErr( 'incomeWitGrown $growTreeId $sum' ); }
		return sum;
	}

	function getOppIncomeWithGrown( growTreeId:Int, trees:Map<Int, Tree> ) {
		
	}

}
