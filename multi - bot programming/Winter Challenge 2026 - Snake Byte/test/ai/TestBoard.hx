package test.ai;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;
import xa3.math.Pos;
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
				ip.board.populateBoard( [], new Set<Int>(), ip.snakebots );
				printErr( "\n" + ip.board.outputBoard());
			});
		});
	}
	
	static function parseInput( input:String ) {
		initReadline( input );

		final myId = parseInt( readline() ); // Your player id (0 or 1)
		final boardWidth = parseInt( readline() ); // The width of the board
		final boardHeight = parseInt( readline() ); // The height of the board
		final boardLines = [for( i in 0...boardHeight ) readline()];

		final wallLines = [for( line in boardLines ) line.split( "" ).map( s -> s == "#" ? "#" : "." ).join( "" )];
		final board = ai.factory.BoardFactory.createBoard( boardWidth, boardHeight, wallLines );

		final powerSources = [];
		for( y in 0...boardLines.length ) {
			final chars = boardLines[y].split( "" );
			for( x in 0...chars.length ) {
				if( chars[x] == "P" ) powerSources.push( board.positions[board.marginY + y][board.marginX + x] );
			}
		}

		final snakes:Map<Int, Array<Pos>> = [];
		for( y in 0...boardLines.length ) {
			final chars = boardLines[y].split( "" );
			for( x in 0...chars.length ) {
				final snakeId = parseInt( chars[x] );
				if( snakeId != null ) {
					if( !snakes.exists( snakeId ) ) snakes[snakeId] = [];
					snakes[snakeId].push( board.positions[board.marginY + y][board.marginX + x] );
				}
			}
		}

		final snakebots = [for( id => positions in snakes ) id => new ai.data.Snakebot( id, positions )];

		return { myId: myId, board: board, powerSources: powerSources, snakebots: snakebots };
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
}