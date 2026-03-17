package test.ai;

import CodinGame.printErr;
import test.ai.ParseInput.parseInput;
import ya.Set;

using StringTools;

class TestBoard extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test createBoard", {
			it( "create empty board", {
				final ip = emptyBoard;
				ip.board.populateBoard( [], new Set<Int>(), new Map<Int, ai.data.Snakebot>() );
				printErr( "\n" + ip.board.outputBoard());
			});

			it( "create board with power source", {
				final ip = powerSourceBoard;
				ip.board.populateBoard( ip.powerSources, new Set<Int>(), new Map<Int, ai.data.Snakebot>() );
				printErr( "\n" + ip.board.outputBoard());
			});

			it( "create board with snake", {
				final ip = snakeBoard;
				ip.board.populateBoard( [], ip.myIds, ip.snakebots );
				printErr( "\n" + ip.board.outputBoard());
			});
			
			it( "create board with snakes and powerups", {
				final ip = allBoard;
				ip.board.populateBoard( ip.powerSources, ip.myIds, ip.snakebots );
				printErr( "\n" + ip.board.outputBoard());
			});
		});
	}
	
	public final emptyBoard = parseInput(
		"0
		3
		3
		...
		...
		###"
	);

	public final powerSourceBoard = parseInput(
		"0
		3
		3
		.P.
		...
		###"
	);

	public final snakeBoard = parseInput(
		"0
		3
		4
		.0.
		.0.
		.0.
		###"
	);

	public final allBoard = parseInput(
		"0
		10
		5
		..........
		.P.0..1.P.
		.#.0..1.#.
		...0..1...
		##########"
	);
}