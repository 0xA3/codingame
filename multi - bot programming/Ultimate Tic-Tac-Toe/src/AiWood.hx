import CodinGame.printErr;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;

class AiWood {

	final player:Int;
	final tree:Node;
	final mcts:MonteCarloTreeSearch;

	public var board:IBoard;
	
	var validPositions:Array<Position>;
	var turn = 0;

	public function new( player:Int, rootBoard:IBoard, tree:Node, mcts:MonteCarloTreeSearch ) {
		this.player = player;
		board = rootBoard;
		this.tree = tree;
		this.mcts = mcts;
	}

	public function setGlobalInputs() { }

	public function setInputs( oy:Int, ox:Int, validPositions:Array<Position> ) {
		this.validPositions = validPositions;
		
		if( oy == -1 ) {
			printErr( 'AiWood makes first move\n' );
			return;
		}
		
		final move = board.positions[oy][ox];
		final nextNode = tree.root.getNodeOfMove( move );
		tree.root = nextNode;
		board = nextNode.state.board;
	}

	public function process() {
		board = mcts.findNextMove( player );
		final move = board.move;

		printErr( 'Player $player: AiWood at $move\n$board' );

		turn++;
		return '${move.y} ${move.x}';
	}
}