import CodinGame.printErr;
import Std.int;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;
import mcts.tictactoe.UltimateBitBoard.ultimatePositions;

class Ai2 {

	// Ultimate board with small boards
	final player:Int;

	var validPositions:Array<Position>;
	
	public var board:IBoard;
	var mcts:MonteCarloTreeSearch;
	var squareIndex = 0;

	var turn = 0;

	public function new( player:Int, rootBoard:IBoard, mcts:MonteCarloTreeSearch ) {
		this.player = player;
		board = rootBoard;
		this.mcts = mcts;
	}

	public function setGlobalInputs() { }

	public function setInputs( oppY:Int, oppX:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		
		if( oppY == -1 ) {
			printErr( 'Player $player Ai2 makes first move\n' );
			return;
		}
		
		final move = ultimatePositions[oppY][oppX];
		final nextNode = mcts.getNodeOfMove( move );
		
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