package game.contexts;

import haxe.Timer;
import game.data.State;
import CodinGame.print;
import CodinGame.printErr;

class BeamSearch {
	
	public static function search( startState:State, k:Int, end:Float ) {
		
		var states:Array<State> = [startState];
		
		var loops = 0;
		var nodes = 0;
		while( Timer.stamp() < end ) {
		// while( loops < 10 ) {
			final candidates:Array<State> = [];
			for( state in states ) {
				final childStates = state.getChildStates();
				for( childState in childStates ) candidates.push( childState );
				if( Timer.stamp() >= end ) break;
			}
			nodes += candidates.length;

			candidates.sort((a, b) -> {
				final aScore = a.score;
				final bScore = b.score;
				if( aScore < bScore ) return 1;
				if( aScore > bScore ) return -1;
				return 0;
			});
			
			states = candidates.slice( 0, k );
			if( states[0].command.actionType == Wait ) break;

			// for( state in states ) printErr( 'BeamSearch:37 ${state.toString()}' );

			loops++;
		}

		// trace state tree
		// for( i in 0...states.length ) trace( '\nstate $i\n${states[i].outputTree()}' );

		var winnerState = states[0];
		// printErr( 'nodes $nodes, depth ${winnerState.depth}' );

		while( winnerState.depth > 1 ) winnerState = winnerState.parent;

		return winnerState;
	}
}

//