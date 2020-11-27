package game.contexts;

import haxe.Timer;
import game.data.State;
import CodinGame.print;

class BeamSearch {
	
	public static function search( startState:State, k:Int, end:Float ) {
		
		var states:Array<State> = [startState];
		
		var loops = 0;
		while( Timer.stamp() < end ) {
		// while( loops < 10 ) {
			final candidates:Array<State> = [];
			for( state in states ) {
				final childStates = state.getChildStates();
				for( childState in childStates ) candidates.push( childState );
			}
			
			candidates.sort((a, b) -> {
				final aScore = a.score;
				final bScore = b.score;
				if( aScore < bScore ) return 1;
				if( aScore > bScore ) return -1;
				return 0;
			});
			
			states = candidates.slice( 0, k );
			if( states[0].action.actionType == Wait ) break;

			for( state in states ) print( 'BeamSearch:33 ${state.toString()}' );

			loops++;
		}

		var winnerState = states[0];
		while( winnerState.depth > 1 ) winnerState = winnerState.parent;

		return winnerState;
	}
}

//