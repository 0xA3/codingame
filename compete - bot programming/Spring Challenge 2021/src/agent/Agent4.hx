package agent;

import CodinGame.printErr;
import Math.min;
import Std.int;
import Std.parseInt;
import game.Constants;
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

class Agent4 extends Agent {

	var startupStep = 0;
	final startupActions = ["G", "G", "S", "G", "S", "G", "S", "G", "S", "G", "S", "G", "G", "G", "S", "G", "S", "G" ];

	final mySeeds:Array<Int>  = [];
	final myTrees1:Array<Int>  = [];
	final myTrees2:Array<Int>  = [];
	final myTrees3:Array<Int>  = [];
	
	var seedCost:Int;
	var completeCost:Int;
	
	// final incomeProgress = [];

	override function takeAction() {

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

		// printErr( 'day $day sun ${me.sun}' );
		final treeInfo = [for( index => tree in myTrees ) '$index T${tree.size}' ].join( "   " );
		// printErr( treeInfo );
		// if( deltaIncome != 1 ) incomeProgress.push( deltaIncome );

		final actionType = startupStep < startupActions.length ? startupActions[startupStep] : getActionType( growCosts, completeCost );
		// printErr( '${startupStep < startupActions.length ? "s" :""} actionType $actionType income $income' );
		
		switch actionType {
			case "G":
				if( growActions.length == 0 ) return "WAIT";
				final treeId = selectGrowAction( growCosts );
				final treeSize = trees[treeId].size;
				final cost = growCosts[treeSize];
				// trace( 'grow costs $growCosts' );
				if( me.sun >= cost ) {
					startupStep++;
					return 'GROW ${treeId}';
				} else return "WAIT";
			
			case "S":
				if( seedActions.length == 0 || me.sun < seedCost ) return "WAIT";	
				final seedAction = selectSeedAction();
				startupStep++;
				return 'SEED ${seedAction[0]} ${seedAction[1]}';
				
			case "C":
				if( completeActions.length == 0 || me.sun < completeCost ) return "WAIT";
				sortCompleteAction();
				// final richnesses = [for( cellId in completeActions ) '$cellId richness ${board.map[board.coords[cellId].s].richness}'];
				// trace( richnesses.join("\n"));
				startupStep++;
				return 'COMPLETE ${completeActions[0]}';
				
				
			default: return "WAIT";
		}
	}

	function getActionType( growCosts:Array<Int>, completeCost:Int ) {
		// printErr( 'day $day sun ${me.sun} costs t1 ${growCosts[0]} t2 ${growCosts[1]} t3 ${growCosts[2]} trees t1 ${myTrees1.length} t2 ${myTrees2.length} t3 ${myTrees3.length}' );	
		if( day < 18 ) {
			if( myTrees3.length > 3 ) {
				if( me.sun >= completeCost ) return 'C';
			} else if( myTrees2.length > 1 ) {
				if( me.sun >= growCosts[2] ) return 'G';
			} else if( myTrees1.length > 1 ) {
				if( me.sun >= growCosts[1] ) return 'G';
			} else if( mySeeds.length > 1 ) {
				if( me.sun >= growCosts[0] ) return 'G';
			} else if( seedActions.length > 0 ) {
				return 'S';
			}
		} else {
			if( myTrees3.length > 0 ) {
				if( me.sun >= completeCost ) return 'C';
			} else if( myTrees2.length > 1 ) {
				if( me.sun >= growCosts[2] ) return 'G';
			} else if( myTrees1.length > 1 ) {
				if( me.sun >= growCosts[1] ) return 'G';
			} else if( mySeeds.length > 1 ) {
				if( me.sun >= growCosts[0] ) return 'G';
			}	
		}
		return "WAIT";
	}

	function selectGrowAction( growCosts:Array<Int> ) {
		if( mySeeds.length > 0 ) { // grow seeds first
			final nonDormantSeeds = mySeeds.filter( seedId -> !myTrees[seedId].isDormant );
			if( nonDormantSeeds.length > 0 ) {
				sortGrowActions( nonDormantSeeds );
				return nonDormantSeeds[0];
			}
		}
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
		// traceGrowActions( growCosts );
		return growActions[0];
	}
	
	inline function sortGrowActions( cellIds:Array<Int> ) {
		ArraySort.sort( cellIds, ( a, b ) -> {
			final avgShadowA = getAverageShadowOfIndex( a, 0 );
			final avgShadowB = getAverageShadowOfIndex( b, 0 );
			if( avgShadowA < avgShadowB ) return -1;
			if( avgShadowA > avgShadowB ) return 1;
			final richnessA = board.cells[a].richness;
			final richnessB = board.cells[b].richness;
			if( richnessA < richnessB ) return 1;
			if( richnessA > richnessB ) return -1;
			return 0;
		});
	}


	function traceGrowActions( growCosts:Array<Int> ) {
		for( treeIndex in growActions ) {
			final tree = trees[treeIndex];
			final cost = growCosts[tree.size];
			final sun = 1 - getAverageShadowOfIndex( treeIndex, tree.size + 1 );
			final gain = sun / cost;
			// printErr( 'tree $treeIndex cost $cost sun $sun  size ${tree.size} gain $gain' );
		}
	}

	function selectSeedAction() {
		sortByTreeSize( seedActions );
		
		final maxSize = trees[seedActions[0][0]].size;
		final highestTreeActions = seedActions.filter( seedAction -> trees[seedAction[0]].size == maxSize );
		sortSeedActions( highestTreeActions );
		
		// traceSeedActions( highestTreeActions );
		return highestTreeActions[0];
	}
	
	inline function sortSeedActions( actions:Array<Array<Int>> ) {
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

	function sortCompleteAction() {
		completeActions.sort(( a, b ) -> {
			final cellA = board.cells[a];
			final cellB = board.cells[b];
			if( cellA.richness < cellB.richness ) return 1;
			if( cellA.richness > cellB.richness ) return -1;
			
			return 0;
		});
	}

}
