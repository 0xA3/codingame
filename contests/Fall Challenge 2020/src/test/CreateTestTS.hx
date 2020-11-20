package test;

import game.data.Player;
import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import Std.parseInt;

class CreateTestTS {
	
	public static function create( player1:Player, player2:Player ) {
		
		final rootBoard = game.data.Board.createEmpty( player1.name );
		rootBoard.updatePlayer( 1, player1.inventory[0], player1.inventory[1], player1.inventory[2], player1.inventory[3], player1.score );
		rootBoard.updatePlayer( 2, player2.inventory[0], player2.inventory[1], player2.inventory[2], player2.inventory[3], player2.score );

		final rootState = new State( rootBoard );
		final rootNode = mcts.tree.Node.fromState( rootState );
		final tree = new mcts.tree.Tree( rootNode );
		final mcts = new mcts.montecarlo.TreeSearch( tree );
		
		return mcts;
	}
}
