import CodinGame.print;
import CodinGame.printErr;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.IBoard;
import mcts.tree.Node;

class Main {
	
	static function main() {
		
		final positions = BitBoard.createPositions();
		final player1 = BitBoard.P1;

		final rootBoard1:IBoard = BitBoard.create( positions );
		final rootState1 = State.fromBoard( player1, rootBoard1 );
		final rootNode1 = Node.fromState( rootState1 );
		final tree1 = new Tree( rootNode1 );
		final mcts1 = new MonteCarloTreeSearch( tree1 );


		final player2 = BitBoard.P2;
		final rootBoard2:IBoard = BitBoard.create( positions );
		final rootState2 = State.fromBoard( player2, rootBoard2 );
		final rootNode2 = Node.fromState( rootState2 );
		final tree2 = new Tree( rootNode2 );
		final mcts2 = new MonteCarloTreeSearch( tree2 );

		final ai1 = new AiWood( BitBoard.P1, rootBoard1, tree1, mcts1 );
		final ai2 = new AiRandom( BitBoard.P2, rootBoard2, tree2, mcts2 );

		final maxMoves = BitBoard.BOARD_SIZE * BitBoard.BOARD_SIZE;

		Sys.println( rootBoard1 );

		var y = -1;
		var x = -1;
		var player = BitBoard.P1;
		var board = rootBoard1;

		for( i in 0...maxMoves ) {
			final validPositions = board.getEmptyPositions();
			
			var action = "";
			if( player == BitBoard.P1 ) {
				ai1.setInputs( y, x, validPositions );
				action = ai1.process();
				board = ai1.board;
			
			} else {
				ai2.setInputs( y, x, validPositions );
				action = ai2.process();
				board = ai2.board;
			}

			final move = action.split(' ').map( parseInt );
			y = move[0];
			x = move[1];

			if( board.status != -1 ) break;
			player = 3 - player;
		}

		Sys.println( board.printStatus());
	}
}
