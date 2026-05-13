package ai.factory;

import CodinGame.printErr;
import ai.data.Board;
import xa3.math.Pos;

class BoardFactory {
	
	public static function createBoard( boardWidth:Int, boardHeight:Int, lines:Array<String >) {
		final positions = Pos.createPositions( boardWidth, boardHeight );
		
		final grid = [for( i in 0...boardHeight ) lines[i].split( "" ).map( Board.getCellType )]; // The current state of the board{
		
		final board = new Board( boardWidth, boardHeight, positions, grid );

		return board;
	}
}