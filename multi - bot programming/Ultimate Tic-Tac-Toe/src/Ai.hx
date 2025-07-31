import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.Board;
import mcts.tictactoe.Position;
import mcts.tree.Tree;

class Ai {

	final positions:Array<Array<Position>>;
	final tree:Tree;
	final mcts:MonteCarloTreeSearch;
	final player = Board.P1;

	var board:Board;

	public function new( positions:Array<Array<Position>>, rootBoard:Board, tree:Tree, mcts:MonteCarloTreeSearch ) {
		this.positions = positions;
		board = rootBoard;
		this.tree = tree;
		this.mcts = mcts;

	}

	public function setGlobalInputs() { }

	public function setInputs( oy:Int, ox:Int, validActionCount:Int) {
		final move = positions[oy][ox];
		
		final nextNode = tree.root.getChildOfMove( move );
		board = nextNode.state.board;
	}

	public function process() {
		board = mcts.findNextMove( player );
		final move = board.move;

		return '${move.y} ${move.x}';
	}


}