package;

import CodinGame.printErr;
import Constants;
import Std.parseInt;
import board.Visualize;
import data.Bomb;
import data.TestCaseDataset;
import data.TestCases;
import haxe.Timer;

using StringTools;

class Sim {
	
	static function main() { new Sim(); }

	public function new() {
		
		final testCases = [
			TestCases.oneNodeOneBomb, 				// 0
			TestCases.threeNodesThreeBombs,			// 1
			TestCases.nineNodesNineBombs,			// 2
			TestCases.fourNodesOneBomb,				// 3
			TestCases.lotOfNodesViewBombs,			// 4
			TestCases.fourScatteredNodesTwoBombs,	// 5
			TestCases.indestructibleNodes,			// 6
			TestCases.forseeTheFuture,				// 7
			TestCases.forseeTheFutureBetter,		// 8
			TestCases.destroyCodinGame,				// 9
			TestCases.notSoFast						// 10
		];

		for( i in 0...testCases.length ) {
			trace( '************** Run test case $i **************' );
			// final i = 9;
			final startTime = Timer.stamp();
			final isWin = simulate( testCases[i] );
			trace( 'Time ${Timer.stamp() - startTime}' );
			if( !isWin ) break;
		}
	}
	
	function simulate( dataset:TestCaseDataset ) {
		final aiBoard = board.Board.create( dataset.width, dataset.height, dataset.grid );
		final ai = new ai.Ai2( aiBoard );

		var board = board.Board.create( dataset.width, dataset.height, dataset.grid );

		var numBombs = dataset.bombs;
		for( i in 0...dataset.rounds ) {
			final action = ai.process( dataset.rounds - i, numBombs );
			
			var bombX = -1;
			var bombY = -1;
			if( action != "WAIT" ) {
				final positions = action.split(" ");
				bombX = parseInt( positions[0] );
				bombY = parseInt( positions[1] );
				if( board.grid[bombY][bombX] == SURVELLANCE_NODE ) {
					trace( 'Error: Bomb ${bombX}:${bombY} can not be positioned on surveillance node' );
					return false;
				}
				if( board.grid[bombY][bombX] == PASSIVE_NODE ) {
					trace( 'Error: Bomb ${bombX}:${bombY} can not be positioned on passive node' );
					return false;
				}

				if( board.grid[bombY][bombX] == BOMB ) {
					trace( 'Error: Bomb ${bombX}:${bombY} can not be positioned on another bomb' );
					return false;
				}

				numBombs--;
			}

			final nextBoard = board.next( bombX, bombY );
			printErr( '> $action\n' + visualize( nextBoard ));

			if( nextBoard.surveillanceNodes.length == 0 ) {
				printErr( '${i + 1} You win!' );
				return true;
			} else if( numBombs == 0 && nextBoard.bombs.length == 0 && nextBoard.surveillanceNodes.length > 0 ) {
				printErr( '${i + 1}\nYou lose!' );
				return false;
			}
			
			board = nextBoard;
		}
		printErr( 'Time is up. You lose!' );
		return false;
	}
}