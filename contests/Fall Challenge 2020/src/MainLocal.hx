package;

import game.data.Action;
import test.CreateTestTS;
import test.mcts.CreateActions;
import game.data.Player;
import haxe.io.Output;
import game.data.Board;
import test.Inputs;
import test.CreatePlayer;
import test.CreateTestMCTS;
import CodinGame.print;

using Lambda;

class MainLocal {
	
	static function main() {
		final name1 = "Crom";
		final name2 = "Hulk";
		final actions = CreateActions.create( Inputs.INPUT_ACTIONS_1_4 );
		
		// for( action in actions ) if( action.actionType == Cast ) trace( action );
		
		var player1 = CreatePlayer.create( Inputs.PLAYERS_EMPTY, 1, name1 );
		var player2 = CreatePlayer.create( Inputs.PLAYERS_EMPTY, 2, name2 );
		
		final mcts1 = CreateTestTS.create( player1, player2 );
		mcts1.updateNode( actions );

		// final mcts2 = CreateTestTS.create( player2, player1 );
		// mcts2.updateNode( actions );

		var output1 = "";
		var output2 = "";
		
		while( true ) {
			
			// trace( 'findnextmove for $name1' );
			final winnerBoard1 = mcts1.findNextMove();

			// trace( 'findnextmove for $name2' );
			// final winnerBoard2 = mcts2.findNextMove();
			
			output1 = winnerBoard1.outputAction();
			// output2 = winnerBoard2.outputAction();
			trace( '${winnerBoard1.me.name}: $output1 inventory: ${winnerBoard1.me.inventory} score ${winnerBoard1.me.score}' );
			// trace( 'action ${winnerBoard2.me.name}: $output2 Score: ${winnerBoard2.me.score}' );

			// trace( winnerBoard1.checkStatus());
			if( winnerBoard1.checkStatus() != InProgress ) {
				break;
			}

			// updates
			
			final winnerBoardActions:Map<Int, Action> = [];
			for( action in winnerBoard1.actions ) {
				winnerBoardActions.set( action.actionId, action );
			}

			mcts1.updateNode(winnerBoardActions );
			// for( action in winnerBoard2.actions ) mcts2.updateNode( action );
			
			player1 = winnerBoard1.me;
			// final player2 = winnerBoard2.me;
			
			winnerBoard1.updatePlayer( 1, player1.inventory[0], player1.inventory[1], player1.inventory[2], player1.inventory[3], player1.score );
			// winnerBoard1.updatePlayer( 2, player2.inventory[0], player2.inventory[1], player2.inventory[2], player2.inventory[3], player2.score );
			
			// winnerBoard2.updatePlayer( 1, player2.inventory[0], player2.inventory[1], player2.inventory[2], player2.inventory[3], player2.score );
			// winnerBoard2.updatePlayer( 2, player1.inventory[0], player1.inventory[1], player1.inventory[2], player1.inventory[3], player1.score );

		}
	}

}
