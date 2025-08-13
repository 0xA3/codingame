import CodinGame.print;
import CodinGame.printErr;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.StatePool;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.UltimateBitBoard;
import mcts.tree.Node;
import mcts.tree.NodePool;

class Main {
	
	static function main() {
		final statePool = new StatePool();
		final nodePool = new NodePool( statePool );

		UltimateBitBoard.createPositions();
		
		final rootBoard1:IBoard = UltimateBitBoard.create();
		final rootState1 = statePool.get( UltimateBitBoard.P1, rootBoard1 );
		final rootNode1 = nodePool.get( rootState1 );
		final mcts1 = new MonteCarloTreeSearch( rootNode1, nodePool, statePool, 0.09 );
		
		
		final rootBoard2:IBoard = UltimateBitBoard.create();
		// final rootState2 = statePool.get( UltimateBitBoard.P2, rootBoard2 );
		// final rootNode2 = nodePool.get( rootState2 );
		// final mcts2 = new MonteCarloTreeSearch( rootNode2, nodePool, statePool, 0.09 );

		
		final me = new Ai2( UltimateBitBoard.P1, rootBoard1, mcts1 );
		final opp = new AiRandom( UltimateBitBoard.P2, rootBoard2 );

		final maxMoves = UltimateBitBoard.ULTIMATE_BOARD_SIZE * UltimateBitBoard.ULTIMATE_BOARD_SIZE;

		// Sys.println( rootBoard1 );

		var y = -1;
		var x = -1;
		var player = UltimateBitBoard.P1;
		var board = rootBoard1;

		for( i in 0...maxMoves ) {
			final validPositions = board.getEmptyPositions();
			// if( player == UltimateBitBoard.P2 ) printErr( 'board\n$board' );
			var action = "";
			if( player == UltimateBitBoard.P1 ) {
				me.setInputs( y, x, validPositions );
				action = me.process();
				board = me.board;
			
			} else {
				opp.setInputs( y, x, validPositions );
				action = opp.process();
				board = opp.board;
			}

			final move = action.split(' ').map( parseInt );
			y = move[0];
			x = move[1];
			
			printErr( 'player $player action $action\n$board' );

			if( board.status != UltimateBitBoard.IN_PROGRESS ) break;
			player = 3 - player;
		}

		Sys.println( board.printStatus());

		Sys.println( 'nodes created ${Node.nodeCount}' );
	}
}
