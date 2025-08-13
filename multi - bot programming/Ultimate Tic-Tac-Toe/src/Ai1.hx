import CodinGame.printErr;
import Std.int;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;

class Ai1 {

	// 9 boards, 9 trees and 9 mctss

	final boards:Array<IBoard>;
	final trees:Array<Node>;
	final mctss:Array<MonteCarloTreeSearch>;
	final player = BitBoard.P1;

	var validPositions:Array<Position>;
	
	public var board:IBoard;
	var tree:Node;
	var mcts:MonteCarloTreeSearch;
	var squareIndex = 0;

	var turn = 0;

	public function new( rootBoards:Array<IBoard>, trees:Array<Node>, mctss:Array<MonteCarloTreeSearch> ) {
		boards = rootBoards;
		this.trees = trees;
		this.mctss = mctss;
	}

	public function setGlobalInputs() { }

	public function setInputs( oppY:Int, oppX:Int, validPositions:Array<Position> ) {
		final oppBoardIndex = Transform.getIndex( oppX, oppY );
		final oppLocalY = Transform.getLocalY( oppY );
		final oppLocalX = Transform.getLocalX( oppX );
		
		this.validPositions = validPositions;
		// printErr( 'setInputs oppSquareIndex $oppSquareIndex, oppX $oppX, oppY $oppY, squareIndex $squareIndex' );
		
		if( oppY != -1 ) {
			board = boards[oppBoardIndex];
			tree = trees[oppBoardIndex];
			mcts = mctss[oppBoardIndex];

			final move = board.positions[oppLocalY][oppLocalX];
			final nextNode = tree.root.getNodeOfMove( move );
			tree.root = nextNode;
			board = nextNode.state.board;
		}
		
		squareIndex = Transform.getIndex( validPositions[0].x, validPositions[0].y );
		board = boards[squareIndex];
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