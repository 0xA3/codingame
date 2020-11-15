package;

import test.Inputs1;
import test.CreateTestSet;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	static function main() {
		final testSet = CreateTestSet.create( Inputs1.INPUT_ACTIONS, Inputs1.PLAYERS );
		final mcts = testSet.mcts;
		var board = testSet.board;
		
		for( i in 0...3 ) {
			final winnerState = mcts.findNextMove( board, 1 );
			board = winnerState.board;
			print( winnerState.action.output() );
		}
	}

}
