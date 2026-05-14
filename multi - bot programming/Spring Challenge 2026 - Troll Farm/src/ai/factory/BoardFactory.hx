package ai.factory;

import CodinGame.printErr;
import ai.data.Board;
import xa3.MTRandom;
import xa3.math.Pos;

class BoardFactory {
	
	public static function createBoard( boardWidth:Int, boardHeight:Int, lines:Array<String >) {
		final positions = Pos.createPositions( boardWidth, boardHeight );
		
		var myShack = Pos.NO_POS;
		var oppShack = Pos.NO_POS;

		var seed = 0;
		final grid = [];
		for( y in 0...boardHeight ) {
			grid.push( [] );
			final line = lines[y].split( "" );
			for( x in 0...boardWidth ) {
				final cell = line[x];
				if( cell == "0" ) myShack = positions[y][x];
				else if( cell == "1" ) oppShack = positions[y][x];
				seed += cell.charCodeAt( 0 );

				grid[y].push( Board.getCellType( cell ) );
			}
		}
		
		final board = new Board( boardWidth, boardHeight, positions, grid, myShack, oppShack );
		MainAi.seed = seed;
		
		return board;
	}
}