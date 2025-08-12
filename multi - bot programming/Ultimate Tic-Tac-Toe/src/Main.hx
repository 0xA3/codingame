import CodinGame.print;
import CodinGame.printErr;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.UltimateBitBoard;
import mcts.tree.Node;
import mcts.tree.NodePool;
import mcts.tree.Tree;

class Main {
	
	static function main() {
		final statePool = new StatePool();
		final nodePool = new NodePool( statePool );

		final player1 = UltimateBitBoard.P1;

		UltimateBitBoard.createPositions();
		final rootBoard1:IBoard = UltimateBitBoard.create();
		final rootState1 = statePool.get( player1, rootBoard1 );
		final rootNode1 = Node.fromState( rootState1 );
		final mcts1 = new MonteCarloTreeSearch( rootNode1, nodePool, statePool, 0.09 );


		final player2 = UltimateBitBoard.P2;
		
		final rootBoard2:IBoard = UltimateBitBoard.create();
		final rootState2 = statePool.get( player2, rootBoard2 );
		final rootNode2 = Node.fromState( rootState2 );
		final mcts2 = new MonteCarloTreeSearch( rootNode2, nodePool, statePool, 0.09 );

		final ai1 = new Ai2( UltimateBitBoard.P1, rootBoard1, mcts1 );
		final ai2 = new AiRandom( UltimateBitBoard.P2, rootBoard2 );

		final maxMoves = UltimateBitBoard.ULTIMATE_BOARD_SIZE * UltimateBitBoard.ULTIMATE_BOARD_SIZE;

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
