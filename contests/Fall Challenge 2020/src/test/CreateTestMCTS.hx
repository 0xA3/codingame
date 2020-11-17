package test;

import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import Std.parseInt;

class CreateTestMCTS {
	
	public static function create( inputActions:String, inputPlayers:String ) {
		
		final rootBoard = game.data.Board.createEmpty();
		final lines = inputActions.split( "\n" );
		
		for( line in lines ) {
			final inputs = line.split(' ');
			final action = ParseAction.parse( inputs );
			rootBoard.addAction( action );
		}

		final lines = inputPlayers.split( "\n" );
		for( i in 0...lines.length ) {
			final inputs = lines[i].split(' ');
			rootBoard.updatePlayer( i + 1,  parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
		}

		final rootState = new State( rootBoard );
		final rootNode = mcts.tree.Node.fromState( rootState );
		final tree = new mcts.tree.Tree( rootNode );
		final mcts = new mcts.montecarlo.MonteCarloTreeSearch( tree );
		
		return mcts;
	}
}
