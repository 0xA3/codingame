package test;

import game.Board;
import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import Std.parseInt;

class CreateTestMCTS {
	
	public static function create( inputActions:String, inputPlayers:String ) {
		
		final rootBoard = game.Board.createEmpty();
		final lines = inputActions.split( "\n" );
		
		for( line in lines ) {
			final inputs = line.split(' ');
			final action = ParseAction.parse( inputs );
			rootBoard.setAction( action.actionId, action );
		}

		final lines = inputPlayers.split( "\n" );
		for( i in 0...lines.length ) {
			final inputs = lines[i].split(' ');
			rootBoard.updatePlayer( i + 1,  parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
		}

		final rootAction = game.Board.waitAction;
		final rootState = mcts.montecarlo.State.fromBoard( rootBoard, rootAction );
		final rootNode = mcts.tree.Node.fromState( rootState );
		final tree = new mcts.tree.Tree( rootNode );
		final mcts = new mcts.montecarlo.MonteCarloTreeSearch( tree );
		
		return mcts;
	}
}
