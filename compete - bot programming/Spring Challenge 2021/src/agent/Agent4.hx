package agent;

import CodinGame.printErr;
import Std.parseInt;
import game.Constants;

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

	final mySeeds:Array<Int>  = [];
	final myTrees1:Array<Int>  = [];
	final myTrees2:Array<Int>  = [];
	final myTrees3:Array<Int>  = [];

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
		final seedCosts = getSeedCost( me );
		final t1Costs = getCostFor( 1, me );
		final t2Costs = getCostFor( 2, me );
		final t3Costs = getCostFor( 3, me );
		final completeCosts = Constants.LIFECYCLE_END_COST;
		// printErr( 'day $day sun ${me.sun}' );
		final treeInfo = [for( index => tree in myTrees ) '$index T${tree.size}' ].join( "   " );
		// printErr( treeInfo );
		// trace( 'possibleActions ${possibleActions.length}' );

		if( day < 18 ) {
			if( myTrees2.length > 1 ) {
				if( me.sun >= t3Costs )	return 'GROW ${myTrees2[0]}';
			} else if( myTrees1.length > 1 ) {
				if( me.sun >= t2Costs )	return 'GROW ${myTrees1[0]}';
			} else if( mySeeds.length > 1 ) {
				if( me.sun >= t1Costs )	return 'GROW ${mySeeds[0]}';
			} else if( seedActions.length > 0 && day < 18 ) {
				seedActions.sort(( a, b ) -> a[1] - b[1] );
				return 'SEED ${seedActions[0][0]} ${seedActions[0][1]}';
			}
		} else {
			if( myTrees3.length > 0 ) {
				if( me.sun >= completeCosts ) return 'COMPLETE ${myTrees3[0]}';
			} else if( myTrees2.length > 1 ) {
				if( me.sun >= t3Costs )	return 'GROW ${myTrees2[0]}';
			} else if( myTrees1.length > 1 ) {
				if( me.sun >= t2Costs )	return 'GROW ${myTrees1[0]}';
			} else if( mySeeds.length > 1 ) {
				if( me.sun >= t1Costs )	return 'GROW ${mySeeds[0]}';
			}	
		}
		return "WAIT";

	}

}