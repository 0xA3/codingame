import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tree.Node;
import mcts.tree.Tree;

class MainAi {
	
	static function main() {
		
		final rootBoards = [for( _ in 0...9 ) BitBoard.create()];
		final rootStates = [for( rootBoard in rootBoards ) State.fromBoard( rootBoard )];
		final rootNodes = [for( rootState in rootStates ) Node.fromState( rootState )];
		final trees = [for( rootNode in rootNodes ) new Tree( rootNode )];
		final mctss = [for( tree in trees ) new MonteCarloTreeSearch( tree )];
		
		final ai = new Ai( rootBoards, trees, mctss );
		ai.setGlobalInputs();

		while( true ) {
			final inputs = readline().split(' ');
			final oppGlobalY = parseInt(inputs[0]);
			final oppGlobalX = parseInt(inputs[1]);
			final oppIndex = Transform.getIndex( oppGlobalX, oppGlobalY );

			final oppLocalY = Transform.getLocalY( oppGlobalY );
			final oppLocalX = Transform.getLocalX( oppGlobalX );

			final validActionCount = parseInt(readline());
			// printErr( 'opponentRow $opponentRow opponentCol $opponentCol validActionCount $validActionCount' );
			
			var index = -1;
			final validPositions = [for( i in 0...validActionCount ) {
				var inputs = readline().split(' ');
				final gy = parseInt(inputs[0]);
				final gx = parseInt(inputs[1]);
				
				index = Transform.getIndex( gx, gy );
				final y = Transform.getLocalY( gy );
				final x = Transform.getLocalX( gx );
				// printErr( 'global $gx:$gy  index $index  local $x:$y' );

				rootBoards[index].positions[y][x];
			}];

			ai.setInputs( oppIndex, oppLocalY, oppLocalX, index, validPositions );

			final action = ai.process();
			print( action );
		}
	}
}