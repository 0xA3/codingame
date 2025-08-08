import CodinGame.printErr;
import Std.int;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;
import mcts.tictactoe.Positions.ultimatePositions;
import mcts.tree.Tree;

class Ai2 {

	// Ultimate board with small boards
	final player:Int;

	var validPositions:Array<Position>;
	
	public var board:IBoard;
	var tree:Tree;
	var mcts:MonteCarloTreeSearch;
	var squareIndex = 0;

	var turn = 0;

	public function new( player:Int, rootBoard:IBoard, tree:Tree, mcts:MonteCarloTreeSearch ) {
		this.player = player;
		board = rootBoard;
		this.tree = tree;
		this.mcts = mcts;
	}

	public function setGlobalInputs() { }

	public function setInputs( oppY:Int, oppX:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		// printErr( 'setInputs oppSquareIndex $oppSquareIndex, oppX $oppX, oppY $oppY, squareIndex $squareIndex' );
		
		if( oppY == -1 ) return;
		
		final move = ultimatePositions[oppY][oppX];
		final nextNode = tree.root.getNodeOfMove( move );
		tree.root = nextNode;
		board = nextNode.state.board;
	}

	public function process() {
		board = mcts.findNextMove( player );
		final move = board.move;
		
		turn++;
		final y = Transform.getGlobalY( squareIndex, move.y );
		final x = Transform.getGlobalX( squareIndex, move.x );
		
		return '$y $x';
	}
}