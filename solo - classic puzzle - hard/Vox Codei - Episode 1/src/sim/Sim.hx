package sim;

import CodinGame.printErr;
import Constants;
import Std.parseInt;
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
	}
	
	function simulate( dataset:TestCaseDataset ) {
		final aiBoard = sim.Board.create( dataset.width, dataset.height, dataset.rows );
		final ai = new ai.Ai1( aiBoard );

		final board = sim.Board.create( dataset.width, dataset.height, dataset.rows );
		trace( "\n" + board.draw() );

		var numBombs = dataset.bombs;
		for( i in 0...dataset.rounds ) {
			
			final action = ai.process( dataset.rounds - i, numBombs );
			
			if( action != "WAIT" ) {
				final positions = action.split(" ");
				final bomb:Bomb = { x: parseInt( positions[0] ), y: parseInt( positions[1] ), time: 3 }
				if( board.grid[bomb.y][bomb.x] == SURVELLANCE_NODE ) {
					trace( 'Error: Bomb ${bomb.x}:${bomb.y} can not be positioned on surveillance node' );
					return;
				}
				if( board.grid[bomb.y][bomb.x] == PASSIVE_NODE ) {
					trace( 'Error: Bomb ${bomb.x}:${bomb.y} can not be positioned on passive node' );
					return;
				}

				board.bombs.push( bomb );
				numBombs--;
			}
			board.updateBombTime();

			if( board.numSurveillanceNodes == 0 ) {
				printErr( '${i + 1} You win!' );
				break;
			} else if( board.bombs.length == 0 && board.numSurveillanceNodes > 0 ) {
				printErr( '${i + 1}\nYou lose!' );
				break;
			} else {
				printErr( '> $action\n' + board.draw() );
			}
			
			board.cleanUp();
		}
	}
}