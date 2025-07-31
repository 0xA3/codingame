import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.Board;
import mcts.tictactoe.Position;
import mcts.tree.Node;
import mcts.tree.Tree;

class Ai {

	final rootBoard:Board;
	final rootState:State;
	final rootNode:Node;
	final tree:Tree;
	final mcts:MonteCarloTreeSearch;
	final player = Board.P1;

	var board:Board;

	public function new() {
		rootBoard = Board.createEmpty();
		rootState = State.fromBoard( rootBoard );
		rootNode = Node.fromState( rootState );
		tree = new Tree( rootNode );
		mcts = new MonteCarloTreeSearch( tree );
		
		// final maxMoves = Board.DEFAULT_BOARD_SIZE * Board.DEFAULT_BOARD_SIZE;
		
		// printErr( rootBoard );

		// var board = rootBoard;
		// for( i in 0...maxMoves ) {
		// }

		// printErr( board.printStatus());


	}

	public function setGlobalInputs() {
		board = rootBoard;
	}

	public function setInputs( oy:Int, ox:Int, validActionCount:Int) {
		board.performMove( Board.P2, { x: ox, y: oy });
	}

	public function process() {
		board = mcts.findNextMove( player );
		
		final move = board.move;

		return '${move.y} ${move.x}';
	}


}