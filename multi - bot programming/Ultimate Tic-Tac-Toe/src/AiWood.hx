import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.Board;
import mcts.tictactoe.Position;
import mcts.tree.Tree;

class Ai {

	final tree:Tree;
	final mcts:MonteCarloTreeSearch;
	final player = Board.P1;

	var board:Board;
	var validPositions:Array<Position>;
	var turn = 0;

	public function new( rootBoard:Board, tree:Tree, mcts:MonteCarloTreeSearch ) {
		board = rootBoard;
		this.tree = tree;
		this.mcts = mcts;
	}

	public function setGlobalInputs() { }

	public function setInputs( oy:Int, ox:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		
		if( oy == -1 ) return;
		
		final move = board.positions[oy][ox];
		final nextNode = tree.root.getNodeOfMove( move );
		tree.root = nextNode;
		board = nextNode.state.board;
	}

	public function process() {
		// board = mcts.findNextMove( player );
		// final move = board.move;

		turn++;
		
		printErr( 'validPositions $validPositions' );

		final randomPosition = validPositions[Std.random( validPositions.length )];
		return '${randomPosition.y} ${randomPosition.x}';
		// return '${move.y} ${move.x}';
	}
}