package sim;

import CodinGame.printErr;
import Constants;
import Std.parseInt;
import board.Visualize;
import data.Bomb;
import data.TestCaseDataset;
import data.TestCases;

using StringTools;

class Sim {
	
	static function main() { new Sim(); }

	public function new() {
		
		final testCases = [
			TestCases.oneNodeOneBomb,
			TestCases.threeNodesThreeBombs,
			TestCases.nineNodesNineBombs,
			TestCases.fourNodesOneBomb,
			TestCases.lotOfNodesViewBombs,
			TestCases.fourScatteredNodesTwoBombs,
			TestCases.indestructibleNodes,
			TestCases.forseeTheFuture,
			TestCases.forseeTheFutureBetter,
			TestCases.destroyCodinGame,
			TestCases.notSoFast
		];

		simulate( testCases[0] );
		// for( i in 0...testCases.length ) {
		// 	trace( '************** Run test case $i **************' );
		// 	final isWin = simulate( testCases[i] );
		// 	if( !isWin ) break;
		// }
		
	}
	
	function simulate( dataset:TestCaseDataset ) {
		final aiBoard = sim.Board.create( dataset.width, dataset.height, dataset.grid );
		final ai = new ai.Ai1( aiBoard );

		var board = sim.Board.create( dataset.width, dataset.height, dataset.grid );
		trace( "\n" + visualize( board ) );

		var numBombs = dataset.bombs;
		for( i in 0...dataset.rounds ) {
			
			final action = ai.process( dataset.rounds - i, numBombs );
			
			if( action != "WAIT" ) {
				final positions = action.split(" ");
				final bomb:Bomb = { x: parseInt( positions[0] ), y: parseInt( positions[1] ), time: 3 }
				if( board.grid[bomb.y][bomb.x] == SURVELLANCE_NODE ) {
					trace( 'Error: Bomb ${bomb.x}:${bomb.y} can not be positioned on surveillance node' );
					return false;
				}
				if( board.grid[bomb.y][bomb.x] == PASSIVE_NODE ) {
					trace( 'Error: Bomb ${bomb.x}:${bomb.y} can not be positioned on passive node' );
					return false;
				}

				board.placeBomb( bomb );
				numBombs--;
			}
			final nextBoard = board.next();
			if( nextBoard.surveillanceNodes.length == 0 ) {
				printErr( '${i + 1} You win!' );
				return true;
			} else if( board.bombs.length == 0 && nextBoard.surveillanceNodes.length > 0 ) {
				printErr( '${i + 1}\nYou lose!' );
				return false;
			} else {
				printErr( '> $action\n' + visualize( nextBoard ) );
			}
			
			board = nextBoard;
		}

		return false;
	}
}