import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.IBoard;
import mcts.tree.Node;
import mcts.tree.Tree;

class MainAi {
	
	static function main() {
		
		final positions = BitBoard.createPositions();

		final rootBoards:Array<IBoard> = [for( _ in 0...9 ) BitBoard.create( positions )];
		final rootStates = [for( rootBoard in rootBoards ) State.create( rootBoard )];
		final rootNodes = [for( rootState in rootStates ) Node.fromState( rootState )];
		final trees = [for( rootNode in rootNodes ) new Tree( rootNode )];
		final mctss = [for( tree in trees ) new MonteCarloTreeSearch( tree )];
		
		final ai = new Ai1( rootBoards, trees, mctss );
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
				final gy = parseInt(inputs[0]);
				final gx = parseInt(inputs[1]);
				
				index = Transform.getIndex( gx, gy );
				final y = Transform.getLocalY( gy );
				final x = Transform.getLocalX( gx );
				// printErr( 'global $gx:$gy  index $index  local $x:$y' );

				rootBoards[index].positions[y][x];
			}];

			ai.setInputs( oppY, oppX, validPositions );

			final action = ai.process();
			print( action );
		}
	}
}