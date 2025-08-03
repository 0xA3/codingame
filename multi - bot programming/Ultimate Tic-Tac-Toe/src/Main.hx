import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tree.Node;
import mcts.tree.Tree;

class Main {
	
	static function main() {
		
		final rootBoard = BitBoard.create();
		final rootState = State.fromBoard( rootBoard );
		final rootNode = Node.fromState( rootState );
		final tree = new Tree( rootNode );
		final mcts = new MonteCarloTreeSearch( tree );
		
		var player = BitBoard.P1;
		final maxMoves = BitBoard.BOARD_SIZE * BitBoard.BOARD_SIZE;

		// final ai = new Ai( rootBoard, tree, mcts );
		// ai.setGlobalInputs();

		Sys.println( rootBoard );

		var board = rootBoard;
		for( i in 0...maxMoves ) {
			board = mcts.findNextMove( player );
			Sys.println( board );
			if( board.status != -1 ) break;
			player = 3 - player;
		}

		Sys.println( board.printStatus());
	}
}
