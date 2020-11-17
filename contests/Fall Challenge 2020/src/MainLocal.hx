package;

import game.data.Board;
import test.Inputs;
import test.CreateTestMCTS;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	static function main() {
		final mcts = CreateTestMCTS.create( Inputs.INPUT_ACTIONS_4, Inputs.PLAYERS_4 );

		var playerNo = 1;
		while( true ) {
			trace( 'findnextmove for player $playerNo' );
			final winnerBoard = mcts.findNextMove( playerNo );
			trace( 'player $playerNo ${winnerBoard.outputAction()} Score ${playerNo == 1 ? winnerBoard.me.score : winnerBoard.opponent.score}' );
			playerNo = 3 - playerNo; // ai playing against itself
			trace( winnerBoard.checkStatus( playerNo ));
			if( winnerBoard.checkStatus( playerNo ) != InProgress ) break;
		}
	}

}
