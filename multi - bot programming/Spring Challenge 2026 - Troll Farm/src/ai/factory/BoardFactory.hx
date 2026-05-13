package ai.factory;

import CodinGame.printErr;
import ai.data.Board;
import xa3.math.Pos;

class BoardFactory {
	
	public static function createBoard( boardWidth:Int, boardHeight:Int, lines:Array<String >) {
		final positions = Pos.createPositions( boardWidth, boardHeight );
		
		final myShacks = [];
		final oppShacks = [];

		final grid = [];
		for( y in 0...boardHeight ) {
			grid.push( [] );
			final line = lines[y].split( "" );
			for( x in 0...boardWidth ) {
				final cell = line[x];
				if( cell == "0" ) myShacks.push( positions[y][x] );
				else if( cell == "1" ) oppShacks.push( positions[y][x] );
				grid[y].push( Board.getCellType( cell ) );
			}
		}
		
		final board = new Board( boardWidth, boardHeight, positions, grid, myShacks, oppShacks );

		return board;
	}
}