package test;

import game.data.State;

class TestBeamSearch {
	
	public static function search( startState:State, k:Int, maxLoops:Int ) {
		
		var states:Array<State> = [startState];
		
		var loops = 0;
		var nodes = 0;
		while( loops < maxLoops ) {
			final candidates:Array<State> = [];
			for( state in states ) {
				final childStates = state.getChildStates();
				for( childState in childStates ) candidates.push( childState );
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
			if( states[0].action.actionType == Wait ) break;

			// for( state in states ) print( 'BeamSearch:33 ${state.toString()}' );

			loops++;
		}

		var winnerState = states[0];
		// printErr( 'nodes $nodes, depth ${winnerState.depth}' );

		while( winnerState.depth > 1 ) winnerState = winnerState.parent;

		return winnerState;
	}
}

//