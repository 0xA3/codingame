import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.Board;
import mcts.tree.Node;
import mcts.tree.Tree;

class Main {
	
	static function main() {
		
		final rootBoard = Board.createEmpty();
		final rootState = State.fromBoard( rootBoard );
		final rootNode = Node.fromState( rootState );
		final tree = new Tree( rootNode );
		final mcts = new MonteCarloTreeSearch( tree );
		
		var player = Board.P1;
		final maxMoves = Board.DEFAULT_BOARD_SIZE * Board.DEFAULT_BOARD_SIZE;

		// final ai = new Ai( rootBoard, tree, mcts );
		// ai.setGlobalInputs();

		Sys.println( rootBoard );

		var board = rootBoard;
		for( i in 0...maxMoves ) {
			board = mcts.findNextMove( player );
			Sys.println( board );
			if( board.checkStatus() != -1 ) break;
			player = 3 - player;
		}

		Sys.println( board.printStatus());
	}
}
