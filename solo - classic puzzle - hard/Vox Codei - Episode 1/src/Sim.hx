import CodinGame.printErr;

import contexts.CreateBoard;
import data.TestCases;
import data.Bomb;
import Std.parseInt;

using StringTools;

class Sim {
	
	final board:Board;

	static function main() { new Sim(); }

	public function new() {
		
		// final ip = TestCases.oneNodeOneBomb;
		final ip = TestCases.threeNodesThreeBombs;
		// final ip = TestCases.nineNodesNineBombs;
		// final ip = TestCases.fourNodesOneBomb;
		// final ip = TestCases.lotOfNodesViewBombs;
		// final ip = TestCases.fourScatteredNodesTwoBombs;
		// final ip = TestCases.indestructibleNodes;
		// final ip = TestCases.forseeTheFuture;
		// final ip = TestCases.forseeTheFutureBetter;
		// final ip = TestCases.destroyCodinGame;
		// final ip = TestCases.notSoFast;
		
		final aiBoard = CreateBoard.create( ip.width, ip.height, ip.rows );
		final ai = new Ai( aiBoard );

		board = CreateBoard.create( ip.width, ip.height, ip.rows );
		trace( "\n" + board.draw() );

		var numBombs = ip.bombs;
		for( i in 0...ip.rounds ) {
			
			final action = ai.process( i, numBombs );
			
			if( action != "WAIT" ) {
				final positions = action.split(" ");
				final bomb:Bomb = { x: parseInt( positions[0] ), y: parseInt( positions[1] ), time: 3 }
				 if( board.grid[bomb.y][bomb.y] == Board.SURVELLANCE_NODE ) {
					trace( 'Error: Bomb ${bomb.x}:${bomb.y} can not be positioned on surveillance node' );
					return;
				}
				if( board.grid[bomb.y][bomb.y] == Board.PASSIVE_NODE ) {
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
				printErr( '${i + 1}\n' + board.draw() );
			}
			
			board.cleanUp();
		}
	}
}