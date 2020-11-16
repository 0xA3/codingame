package;

import game.Board;
import test.Inputs;
import test.CreateTestMCTS;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	static function main() {
		final mcts = CreateTestMCTS.create( Inputs.INPUT_ACTIONS_2, Inputs.PLAYERS_2 );

		var playerNo = 1;
		while( true ) {
			final winnerBoard = mcts.findNextMove( playerNo );
			if( playerNo == 1 ) trace( 'player $playerNo ${winnerBoard.outputAction()}' );
			// playerNo = 3 - playerNo; // ai playing against itself
			if( winnerBoard.checkStatus( playerNo ) != Board.IN_PROGRESS ) break;
		}
	}

}
