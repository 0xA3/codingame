package ai.factory;

import CodinGame.printErr;
import Std.int;
import ai.data.Board;
import haxe.io.Path;
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

				grid[y].push( getCellType( cell ) );
			}
		}
		
		final pathFactory = new PathsFactory( boardWidth, boardHeight, grid, positions, myShack );
		final shackPaths = pathFactory.createShackPaths();

		final board = new Board( boardWidth, boardHeight, positions, grid, shackPaths, myShack, oppShack );
		MainAi.seed = seed;
		
		return board;
	}

	static function getCellType( s:String ) {
		switch( s ) {
			case "~": return Board.WATER; // ~ for WATER
			case "#": return Board.ROCK; // # for ROCK
			case "+": return Board.IRON; // + for IRON
			case "0": return Board.MY_SHACK; // 0 for your own SHACK
			case "1": return Board.OPP_SHACK; // 1 for your opponent's SHACK
			default:  return Board.GRASS; // . for GRASS
		}
	}
}
