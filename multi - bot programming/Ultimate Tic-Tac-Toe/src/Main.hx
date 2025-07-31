import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.tictactoe.Board;
import mcts.tictactoe.Position;
import mcts.tree.Node;
import mcts.tree.Tree;

class Main {
	
	static function main() {
		
		final positions:Array<Position> = [for( y in 0...3 ) [for( x in 0...3 ) { x: x, y: y }]];
		final rootBoard = Board.createEmpty();
		final rootState = State.fromBoard( rootBoard );
		final rootNode = Node.fromState( rootState );
		final tree = new Tree( rootNode );
		final mcts = new MonteCarloTreeSearch( tree );
		
		final ai = new Ai( positions, rootBoard, rootState, rootNode, tree, mcts );
		ai.setGlobalInputs();

		while( true ) {
			final inputs = readline().split(' ');
			final opponentRow = parseInt(inputs[0]);
			final opponentCol = parseInt(inputs[1]);
			final validActionCount = parseInt(readline());
			// printErr( 'opponentRow $opponentRow opponentCol $opponentCol validActionCount $validActionCount' );

			for( i in 0...validActionCount ) {
				var inputs = readline().split(' ');
				final row = parseInt(inputs[0]);
				final col = parseInt(inputs[1]);

				// printErr( 'row $row col $col' );
			}
			if( opponentRow != -1 ) ai.setInputs( opponentRow, opponentCol, validActionCount );

			final action = ai.process();

			print('0 0');
		}

	}
}
