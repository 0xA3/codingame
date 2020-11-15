package;

import test.Inputs1;
import test.CreateTestMCTS;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	static function main() {
		final mcts = CreateTestMCTS.create( Inputs1.INPUT_ACTIONS, Inputs1.PLAYERS );

		for( i in 0...10 ) {
			final winnerState = mcts.findNextMove( 1 );
			// print( winnerState.action.output() );
		}
	}

}
