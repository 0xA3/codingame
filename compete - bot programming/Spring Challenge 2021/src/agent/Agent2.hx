package agent;

import CodinGame.printErr;
import Std.parseInt;
import game.Constants;

using Lambda;

class Agent2 extends Agent {

	final growActions:Array<Int> = [];
	final completeActions:Array<Int> = [];
	final seedActions:Array<Array<Int>> = [];

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

		if( myTrees3.length > 1 ) {
			if( me.sun >= completeCosts ) return 'COMPLETE ${myTrees3[0]}';
		} else if( myTrees2.length > 1 ) {
			if( me.sun >= t3Costs )	return 'GROW ${myTrees2[0]}';
		} else if( myTrees1.length > 1 ) {
			if( me.sun >= t2Costs )	return 'GROW ${myTrees1[0]}';
		} else if( mySeeds.length > 1 ) {
			if( me.sun >= t1Costs )	return 'GROW ${mySeeds[0]}';
		} else if( seedActions.length > 0 ) {
			seedActions.sort(( a, b ) -> a[1] - b[1] );
			// printErr( seedActions );
			return 'SEED ${seedActions[0][0]} ${seedActions[0][1]}';
		}
		return "WAIT";

	}

	function parsePossibleActions( possibleActions:Array<String> ) {
		growActions.splice( 0, growActions.length );
		completeActions.splice( 0, completeActions.length );
		seedActions.splice( 0, seedActions.length );

		for( action in possibleActions ) {
			if( action != "WAIT" ) {
				final parts = action.split(" ");
				final command = parts[0];
				switch command {
				case "GROW": growActions.push( parseInt( parts[1] ));
				case "COMPLETE": completeActions.push( parseInt( parts[1] ));
				case "SEED": seedActions.push( [parseInt( parts[1] ), parseInt( parts[2] )] );
				default: throw 'Error unknown command $action';
				}
			}
		}
	}
}