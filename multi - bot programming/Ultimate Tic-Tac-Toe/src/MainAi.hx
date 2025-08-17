import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.UltimateBitBoard.ultimatePositions;
import mcts.tictactoe.UltimateBitBoard;
import mcts.tree.Node;
import mcts.tree.NodePool;

class MainAi {
	
	static function main() {
		final statePool = new StatePool();
		final nodePool = new NodePool( statePool );
		
		UltimateBitBoard.createPositions();
		
		final player1 = UltimateBitBoard.P1;
		final rootBoard1:IBoard = UltimateBitBoard.create();
		final rootState1 = statePool.get( UltimateBitBoard.P1, rootBoard1 );
		final rootNode1 = nodePool.get( rootState1 );
		final mcts1 = new MonteCarloTreeSearch( rootNode1, nodePool, statePool, 0.09 );
		
		// final ai = new AiRandom( UltimateBitBoard.P1, rootBoard1, tree1, mcts1 );
		final ai = new Ai2( UltimateBitBoard.P1, rootBoard1, mcts1 );
		ai.setGlobalInputs();

		while( true ) {
			final inputs = readline().split(' ');
			final oppY = parseInt(inputs[0]);
			final oppX = parseInt(inputs[1]);

			final validActionCount = parseInt(readline());
			// printErr( 'opponentRow $opponentRow opponentCol $opponentCol validActionCount $validActionCount' );
			
			var index = -1;
			final validPositions = [for( i in 0...validActionCount ) {
				var inputs = readline().split(' ');
				final y = parseInt(inputs[0]);
				final x = parseInt(inputs[1]);
				
				ultimatePositions[y][x];
			}];

			ai.setInputs( oppY, oppX, validPositions );

			final action = ai.process();
			print( action );
		}
	}
}