package ai.factory;

import ai.data.Board;
import xa3.math.Pos;

class BoardFactory {
	
	public static function createBoard( boardWidth:Int, boardHeight:Int, lines:Array<String >) {
		final marginX = boardWidth;
		final marginY = boardHeight;

		final marginBoardWidth = marginX * 2 + boardWidth;
		final marginBoardHeight = marginY * 2 + boardHeight;

		final positions = Pos.createPositions( marginBoardWidth, marginBoardHeight );
		
		final grid = [for( i in 0...boardHeight ) lines[i].split( "" ).map( s -> s == "." ? Board.EMPTY : Board.WALL )]; // The current state of the board{
		final marginGrid = createMarginGrid( boardWidth, boardHeight, marginX, marginY, grid );
		
		final board = new Board( boardWidth, boardHeight, marginX, marginY, marginBoardWidth, marginBoardHeight, positions, marginGrid );

		return board;
	}

	static function createMarginGrid( gridWidth:Int, gridHeight:Int, marginX:Int, marginY:Int, grid:Array<Array<Int>> ) {
		final marginGrid = [for( y in 0...gridHeight + marginY * 2 ) []];
		
		for( y in 0...marginY ) for( x in 0...marginX * 2 + gridWidth ) marginGrid[y].push( Board.EMPTY );
		
		for( y in 0...gridHeight ) {
			for( x in 0...marginX ) marginGrid[y + marginY].push( Board.EMPTY );
			for( x in 0...gridWidth ) marginGrid[y + marginY].push( grid[y][x] );
			for( x in 0...marginX ) marginGrid[y + marginY].push( Board.EMPTY );
		}
		
		for( y in 0...marginY ) for( x in 0...marginX * 2 + gridWidth ) marginGrid[y + marginY + gridHeight].push( Board.EMPTY );
		// printErr( marginGrid.map( s -> s.join( "" ) ).join( "\n" ) );
		
		return marginGrid;
	}
}