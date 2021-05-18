package agent;

import CodinGame.printErr;
import Math.min;
import Std.int;
import Std.parseInt;
import agent.TActionType;
import game.Board;
import game.Constants;
import game.Player;
import haxe.Rest;
import haxe.ds.ArraySort;

using Lambda;

/* Decisions
when not enough sun points WAIT
grow or seed or complete
phases
1 expand
2 complete

phase 1 optimize grows for cost / sun points
mix in percentage of seeding
complete to reduce t3 costs
where loss of sun points is minimal

phase 2 optimize for points
calculate costs to grow gemaining trees
use sun overhead to seed
complete in order of max points

*/

class Agent5 extends Agent {

	var startupStep = 0;
	final startupActions = [Grow, Grow];
	final growWeights = [1, 1.2, 2];

	final mySeeds:Array<Int>  = [];
	final myTrees1:Array<Int>  = [];
	final myTrees2:Array<Int>  = [];
	final myTrees3:Array<Int>  = [];
	
	var seedCost:Int;
	var completeCost:Int;
	
	// final incomeProgress = [];
	var income = 2.0;

	var state:TState;

	public function new( me:Player, opp:Player, board:Board ) {
		super( me, opp, board );
		state = Expansion;
	}

	override function takeAction() {
		if( day == 8 && state == Expansion ) state = Sustain;
		if( day == 18 && state == Sustain ) state = Contraction;

		myTrees.clear();
		mySeeds.splice( 0, mySeeds.length );
		myTrees1.splice( 0, myTrees1.length );
		myTrees2.splice( 0, myTrees2.length );
		myTrees3.splice( 0, myTrees3.length );
		
		for( index => tree in trees ) if( tree.owner.index == me.index ) {
			myTrees.set( index, tree );
			switch tree.size {
			case 0: mySeeds.push( index );
			case 1: myTrees1.push( index );
			case 2: myTrees2.push( index );
			case 3: myTrees3.push( index );
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
		income = getIncome();
		
		// trace( 'seedCost $seedCost growCosts $growCosts' );

		// printErr( 'day $day sun ${me.sun}' );
		final treeInfo = [for( index => tree in myTrees ) '$index T${tree.size}' ].join( "   " );
		// printErr( treeInfo );

		final actionType = startupStep < startupActions.length
			? startupActions[startupStep]
			: getActionType( seedCost, growCosts, completeCost, income );
		
		// printErr( '${startupStep < startupActions.length ? "s" :""} actionType $actionType income $income' );
		
		switch actionType {
			case Grow:
				if( growActions.length == 0 ) return "WAIT";
				final treeId = selectGrowAction( growCosts, growWeights );
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
		
		if( seedCost == 0 && seedActions.length > 0 ) return Seed;
		// printErr( 'day $day sun ${me.sun} costs t1 ${growCosts[0]} t2 ${growCosts[1]} t3 ${growCosts[2]} trees t1 ${myTrees1.length} t2 ${myTrees2.length} t3 ${myTrees3.length}' );	
		if( myTrees3.length > 0 ) {
			// final losses = myTrees3.map( treeId -> getAverageLoss( treeId ));
			// losses.sort(( a, b ) -> {
			// 	if( a < b ) return -1; // lowest first
			// 	if( a > b ) return 1;
			// 	return 0;
			// });
			// final lossOutput = [for( i in 0...myTrees3.length ) 'tree ${myTrees3[i]} loss ${losses[i]}'];
			// trace( lossOutput.join("  "));
			// if( losses[0] < 3 ) return "C";

			final incomesWithoutTree = myTrees3.map( treeId -> getIncome( treeId ));
			final losses = incomesWithoutTree.map( incomeWithout -> income - incomeWithout );
			final lossOutput = [for( i in 0...myTrees3.length ) 'without tree ${myTrees3[i]} loss ${losses[i]}'];
			// trace( 'state $state income $income - ' + lossOutput.join("  "));
			
			final lowestLoss = losses.fold(( income, max ) -> Math.min( income, max ), 9999.0 );
			final lowestLossIndex = losses.indexOf( lowestLoss );
			
			switch state {
				case Expansion: if( lowestLoss <= 1 ) return Complete( myTrees3[lowestLossIndex] );
				case Sustain: if( income - lowestLoss > 10 ) return Complete( myTrees3[lowestLossIndex] );
				case Contraction: if( income - lowestLoss > 5 ) return Complete( myTrees3[lowestLossIndex] );
			}
			
		}
		
		return Grow;

	}
	function getIncome( withoutTreeId = -1 ) {
		var sum = 0.0;
		
		for( index => tree in myTrees ) {
			if( index != withoutTreeId ) {
				final avgShadow = getAverageShadowOfIndex( index, tree.size );
				sum += ( 1 - avgShadow ) * tree.size;
			}
		}
		// if( withoutTreeId == -1 ) {
		// 	printErr( 'income $sum  ' );
		// } else {
		// 	printErr( 'incomeWithout $withoutTreeId $sum  ' );
		// }
		return sum;
	}

	function selectGrowAction( growCosts:Array<Int>, growWeights:Array<Float> ) {
		// traceGrowActions( growCosts );
		switch state {
			case Expansion: sortGrowActionsBySun( growCosts );
			case Sustain: sortGrowActionsByRichness( growCosts );
			case Contraction: sortGrowActionsByRichness( growCosts );
		}
		return growActions[0];
	}
	
	function sortGrowActionsBySun( growCosts:Array<Int> ) {
		growActions.sort(( a, b ) -> {
			final treeA = trees[a];
			final treeB = trees[b];
			final costA = growCosts[treeA.size];
			final costB = growCosts[treeB.size];
			final sunA = 1 - getAverageShadowOfIndex( a, treeA.size + 1 );
			final sunB = 1 - getAverageShadowOfIndex( b, treeB.size + 1 );
			final gainA = sunA / costA;
			final gainB = sunB / costB;
			if( gainA < gainB ) return 1;
			if( gainA > gainB ) return -1;
			return 0;
		});
	}
	
	function sortGrowActionsByRichness( growCosts:Array<Int> ) {
		growActions.sort(( a, b ) -> {
			final richnessA = board.cells[a].richness;
			final richnessB = board.cells[b].richness;
			if( richnessA < richnessB ) return 1; // highest richness
			if( richnessA > richnessB ) return -1;
			return 0;
		});
	}

	function traceGrowActions( growCosts:Array<Int> ) {
		for( treeIndex in growActions ) {
			final tree = trees[treeIndex];
			final cost = growCosts[tree.size];
			final sun = 1 - getAverageShadowOfIndex( treeIndex, tree.size + 1 );
			final sunPerCost = sun / cost;
			printErr( 'tree $treeIndex cost $cost sun $sun  size ${tree.size} sunPerCost $sunPerCost' );
		}
	}

	function selectSeedAction() {
		sortByTreeSize( seedActions );
		
		final maxSize = trees[seedActions[0][0]].size;
		final highestTreeActions = seedActions.filter( seedAction -> trees[seedAction[0]].size == maxSize );
		switch state {
			case Expansion: sortSeedActionsBySun( highestTreeActions );
			case Sustain: sortSeedActionsByRichness( highestTreeActions );
			case Contraction: sortSeedActionsByRichness( highestTreeActions );
		}
		
		
		// traceSeedActions( highestTreeActions );
		return highestTreeActions[0];
	}
	
	// phase 1 sort by sun
	inline function sortSeedActionsBySun( actions:Array<Array<Int>> ) {
		ArraySort.sort( actions, ( a, b ) -> {
			final targetIdA = a[1];
			final targetIdB = b[1];
			final avgShadowA = getAverageShadowOfIndex( targetIdA, 0 );
			final avgShadowB = getAverageShadowOfIndex( targetIdB, 0 );
			if( avgShadowA < avgShadowB ) return -1; // lowest shadow
			if( avgShadowA > avgShadowB ) return 1;
			final richnessA = board.cells[targetIdA].richness;
			final richnessB = board.cells[targetIdB].richness;
			if( richnessA < richnessB ) return 1; // highest richness
			if( richnessA > richnessB ) return -1;
			return 0;
		});
	}
	// phase 2 sort by richness
	
	inline function sortSeedActionsByRichness( actions:Array<Array<Int>> ) {
		ArraySort.sort( actions, ( a, b ) -> {
			final targetIdA = a[1];
			final targetIdB = b[1];
			final avgShadowA = getAverageShadowOfIndex( targetIdA, 0 );
			final avgShadowB = getAverageShadowOfIndex( targetIdB, 0 );
			if( avgShadowA < avgShadowB ) return -1; // lowest shadow
			if( avgShadowA > avgShadowB ) return 1;
			final richnessA = board.cells[targetIdA].richness;
			final richnessB = board.cells[targetIdB].richness;
			if( richnessA < richnessB ) return 1; // highest richness
			if( richnessA > richnessB ) return -1;
			return 0;
		});
	}


	function traceSeedActions( seedActions:Array<Array<Int>>) {
		final indexStats = seedActions.map( seedAction -> {
			final sourceId = seedAction[0];
			final targetId = seedAction[1];
			final richness = board.cells[targetId].richness;
			final avgShadow = getAverageShadowOfIndex( targetId, 0 );
			return 'seed $sourceId -> $targetId  richness $richness shadow $avgShadow';
		});
		printErr( "\n" + indexStats.join( "\n" ));
	}

	function sortByTreeSize( actions:Array<Array<Int>> ) { // highest first
		ArraySort.sort( seedActions, ( a, b ) -> {
			final sourceIdA = a[0];
			final sourceIdB = b[0];
			final heightA = trees[sourceIdA].size;
			final heightB = trees[sourceIdB].size;
			if( heightA < heightB ) return 1;
			if( heightA > heightB ) return -1;
			return 0;
		});
	}

	function sortCompleteAction( treeIndices:Array<Int> ) {
		treeIndices.sort(( a, b ) -> {
			final cellA = board.cells[a];
			final cellB = board.cells[b];
			if( cellA.richness < cellB.richness ) return 1; // highest first
			if( cellA.richness > cellB.richness ) return -1;
			final lossA = getAverageLoss( a );
			final lossB = getAverageLoss( b );
			if( lossA < lossB ) return -1; // lowest first
			if( lossA > lossB ) return 1;
			return 0;
		});
		traceCompleteActions( treeIndices );
	}
	
	function traceCompleteActions( treeIndices:Array<Int> ) {
		for( treeIndex in treeIndices ) {
			final richness = board.cells[treeIndex].richness;
			final loss = getAverageLoss( treeIndex );
			printErr( 'tree $treeIndex richness $richness loss $loss' );
		}
	}

	function getAverageLoss( cellId:Int ) {
		final avgSun = 1 - getAverageShadowOfIndex( cellId, 3 );
		return avgSun * 3;
	}

}
