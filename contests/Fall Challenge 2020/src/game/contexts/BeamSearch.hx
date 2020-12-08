package game.contexts;

import haxe.Timer;
import game.data.State;
import CodinGame.print;
import CodinGame.printErr;

class BeamSearch {
	
	// public static var breakEnd:Float;
	// public static var recurseStart:Float;

	public static function search( startState:State, k:Int, end:Float, step:Int ) {
		
		final states:Array<State> = [startState];
		
		var loops = 0;
		var nodes = 0;
		while( Timer.stamp() < end && loops + step < 100 ) {
			final candidates = new MaxPriorityQueue<State>( compareStates );
			for( state in states ) {
				final childStates = state.getChildStates();
				for( childState in childStates ) candidates.insert( childState );
				// breakEnd = Timer.stamp();
				// if( breakEnd >= end ) {
				if( Timer.stamp() >= end ) {
					break;
				}
			}
			nodes += candidates.size();
			
			states.splice( 0, states.length );
			for( i in 0...k ) {
				if( candidates.isEmpty()) break;
				final state = candidates.delMax();
				// trace( '$state score ${state.score}' );
				states.push( state );
			}
			if( states[0].command.actionType == Wait ) break;
			// for( state in states ) printErr( 'BeamSearch:37 ${state.toString()}' );
			loops++;
		}

		/* trace state tree */
		// for( i in 0...states.length ) trace( '\nstate $i\n${states[i].outputTree()}' );

		var winnerState = states[0];
		// printErr( 'nodes $nodes, depth ${winnerState.depth}' );

		// if( step == 53 ) trace( winnerState.outputTree() );
		// printErr( winnerState.outputTree() );

		// recurseStart = Timer.stamp();
		while( winnerState.depth > 1 ) winnerState = winnerState.parent;

		return winnerState;
	}

	static inline function compareStates( a:State, b:State ) {
		if( a.score > b.score ) return true;
		return false;
	}
}

//