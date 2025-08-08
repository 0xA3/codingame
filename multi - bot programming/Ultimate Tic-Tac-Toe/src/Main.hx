import CodinGame.print;
import CodinGame.printErr;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Positions;
import mcts.tictactoe.UltimateBitBoard;
import mcts.tree.Node;
import mcts.tree.Tree;

class Main {
	
	static function main() {
		
		Positions.create();
		final player1 = UltimateBitBoard.P1;

		final rootBoard1:IBoard = UltimateBitBoard.create();
		final rootState1 = State.fromBoard( player1, rootBoard1 );
		final rootNode1 = Node.fromState( rootState1 );
		final tree1 = new Tree( rootNode1 );
		final mcts1 = new MonteCarloTreeSearch( tree1, 0.09 );


		final player2 = UltimateBitBoard.P2;
		final rootBoard2:IBoard = UltimateBitBoard.create();
		final rootState2 = State.fromBoard( player2, rootBoard2 );
		final rootNode2 = Node.fromState( rootState2 );
		final tree2 = new Tree( rootNode2 );
		final mcts2 = new MonteCarloTreeSearch( tree2, 0.09 );

		final ai1 = new Ai2( UltimateBitBoard.P1, rootBoard1, tree1, mcts1 );
		final ai2 = new AiRandom( UltimateBitBoard.P2, rootBoard2, tree2, mcts2 );

		final maxMoves = UltimateBitBoard.BOARD_SIZE * UltimateBitBoard.BOARD_SIZE;

		// Sys.println( rootBoard1 );

		var y = -1;
		var x = -1;
		var player = UltimateBitBoard.P1;
		var board = rootBoard1;

		for( i in 0...maxMoves ) {
			final validPositions = board.getEmptyPositions();
			
			var action = "";
			if( player == UltimateBitBoard.P1 ) {
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

		Sys.println( 'nodes created ${Node.nodeCount}' );
	}
}
