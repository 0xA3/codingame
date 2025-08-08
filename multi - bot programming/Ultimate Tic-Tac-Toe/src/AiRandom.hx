import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;
import mcts.tictactoe.Positions.ultimatePositions;
import mcts.tree.Tree;

class AiRandom {

	final player:Int;
	
	public var board:IBoard;
	
	var validPositions:Array<Position>;

	public function new( player:Int, rootBoard:IBoard, tree:Tree, mcts:MonteCarloTreeSearch ) {
		this.player = player;
		board = rootBoard;
	}

	public function setGlobalInputs() { }

	public function setInputs( oy:Int, ox:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;

		if( oy == -1 ) {
			printErr( 'Player $player AiRandom makes first move\n' );
			return;
		}
		
		board.performMove( 3 - player, ultimatePositions[oy][ox] );
	}

	public function process() {
		final randomPosition = validPositions[Std.random( validPositions.length )];
		board.performMove( player, randomPosition );
		
		// printErr( 'Player $player AiRandom at $randomPosition\n$board' );
		
		return '${randomPosition.y} ${randomPosition.x}';
	}
}