package test;

import game.Board;
import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import Std.parseInt;

class CreateTestSet {
	
	public static function create( inputActions:String, inputPlayers:String ) {
		
		final mcts = new MonteCarloTreeSearch();
		final board = Board.createEmpty();
		final lines = inputActions.split( "\n" );
		for( line in lines ) {
			final inputs = line.split(' ');
			final action = ParseAction.parse( inputs );
			board.setAction( action.actionId, action );
		}

		final lines = inputPlayers.split( "\n" );
		for( i in 0...lines.length ) {
			final inputs = lines[i].split(' ');
			board.updatePlayer( i + 1,  parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
		}

		return { mcts: mcts, board: board }
	}
}

typedef TestSet = {
	final mcts:MonteCarloTreeSearch;
	final board:Board;
}