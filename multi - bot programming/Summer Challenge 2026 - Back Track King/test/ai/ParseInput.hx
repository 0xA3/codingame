package test.ai;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;
import xa3.math.Pos;

typedef ParsedInput = {
	final boardWidth:Int;
	final boardHeight:Int;
	final grid:Array<Array<Int>>;
	final positions:Array<Array<Pos>>;
}

@:access( ai.factory.BoardFactory )
class ParseInput {

	public static function parseInput( input:String ) {
		initReadline( input );
		final boardWidth = parseInt( readline() ); // The width of the board
		final boardHeight = parseInt( readline() ); // The height of the board
		
		final lines = [for( i in 0...boardHeight ) readline()];
		
		final positions = Pos.createPositions( boardWidth, boardHeight );
		final grid = [];
		for( y in 0...boardHeight ) {
			grid.push( [] );
			final line = lines[y].split( "" );
			for( x in 0...boardWidth ) {
				final cell = line[x];
				grid[y].push( ai.factory.BoardFactory.getCellType( cell ) );
			}
		}

		return { boardWidth: boardWidth, boardHeight: boardHeight, grid: grid, positions: positions };
	}
}