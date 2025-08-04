import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;
import mcts.tree.Tree;

class AiRandom {

	var player = BitBoard.P2;
	var opp = BitBoard.P1;
	
	public var board:IBoard;
	
	var validPositions:Array<Position>;

	public function new( rootBoard:IBoard, tree:Tree, mcts:MonteCarloTreeSearch ) {
		board = rootBoard;
	}

	public function setGlobalInputs() { }

	public function setInputs( oy:Int, ox:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		
		if( oy == -1 ) {
			player = BitBoard.P1;
			opp = BitBoard.P2;
			return;
		}
		
		board.performMove( opp, board.positions[oy][ox] );
	}

	public function process() {
		final randomPosition = validPositions[Std.random( validPositions.length )];
		board.performMove( player, randomPosition );
		
		// printErr( board );
		
		return '${randomPosition.y} ${randomPosition.x}';
	}
}