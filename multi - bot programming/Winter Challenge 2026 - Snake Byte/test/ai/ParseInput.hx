package test.ai;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;
import xa3.math.Pos;
import ya.Set;

typedef ParsedInput = {
	var myId: Int;
	var board: ai.data.Board;
	var powerSources: Array<Pos>;
	var myIds: Set<Int>;
	var oppIds: Set<Int>;
	var snakebots: Map<Int, ai.data.Snakebot>;
}

class ParseInput {
	
	public static function parseInput( input:String ) {
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

		final allIds = [for( id in snakes.keys() ) id];
		final myIdsLength = Math.ceil( allIds.length / 2 );

		final myIds = new Set();
		for( i in 0...myIdsLength ) myIds.add( allIds[i] );
		final oppIds = new Set();
		for( i in myIdsLength...allIds.length ) oppIds.add( allIds[i] );

		final snakebots = [for( id => positions in snakes ) id => new ai.data.Snakebot( id, positions )];

		return { myId: myId, board: board, powerSources: powerSources, myIds: myIds, oppIds: oppIds, snakebots: snakebots };
	}
}
