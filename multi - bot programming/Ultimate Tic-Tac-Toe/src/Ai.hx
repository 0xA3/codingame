import CodinGame.printErr;
import Std.int;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.Position;
import mcts.tree.Tree;

class Ai {

	final boards:Array<BitBoard>;
	final trees:Array<Tree>;
	final mctss:Array<MonteCarloTreeSearch>;
	final player = BitBoard.P1;

	var validPositions:Array<Position>;
	
	var board:BitBoard;
	var tree:Tree;
	var mcts:MonteCarloTreeSearch;
	var squareIndex = 0;

	var turn = 0;

	public function new( rootBoards:Array<BitBoard>, trees:Array<Tree>, mctss:Array<MonteCarloTreeSearch> ) {
		boards = rootBoards;
		this.trees = trees;
		this.mctss = mctss;
	}

	public function setGlobalInputs() { }

	public function setInputs( oppSquareIndex:Int, oppY:Int, oppX:Int, squareIndex:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		// printErr( 'setInputs oppSquareIndex $oppSquareIndex, oppX $oppX, oppY $oppY, squareIndex $squareIndex' );
		
		if( oppY != -1 ) {
			board = boards[oppSquareIndex];
			tree = trees[oppSquareIndex];
			mcts = mctss[oppSquareIndex];

			final move = board.positions[oppY][oppX];
			final nextNode = tree.root.getNodeOfMove( move );
			tree.root = nextNode;
			board = nextNode.state.board;
		}
		
		this.squareIndex = squareIndex;
		board = boards[squareIndex];
		tree = trees[squareIndex];
		mcts = mctss[squareIndex];
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