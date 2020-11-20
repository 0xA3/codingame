package;

import game.contexts.ParseAction;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.TreeSearch;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import game.data.Board;

using Lambda;

class Main {
	
	static function main() {
		
		final rootBoard = Board.createEmpty( "Crom" );
		final rootState = new mcts.montecarlo.State( rootBoard );
		final rootNode = mcts.tree.Node.fromState( rootState );
		final tree = new mcts.tree.Tree( rootNode );
		final mcts = new TreeSearch( tree );

		var board = tree.rootNode.state.board;
		while( true ) {
			final actionCount = parseInt( readline() ); // the number of spells and recipes in play
			final actions = [for( i in 0...actionCount ) {
				final line = readline();
				// printErr( line );
				final action = ParseAction.parse( line.split(' '));
				action.actionId => action;
			}];
			mcts.updateNode( actions );
			
			for( i in 0...2 ) {
				final inputs = readline().split( ' ' );
				// printErr( inputs.join(" "));
				board.updatePlayer( i + 1,  parseInt( inputs[0] ), parseInt( inputs[1] ), parseInt( inputs[2] ), parseInt( inputs[3] ), parseInt( inputs[4] ));
			}
		
			board = mcts.findNextMove();
			print( board.outputAction() );
			// print( "WAIT" );
		}

	}

}
