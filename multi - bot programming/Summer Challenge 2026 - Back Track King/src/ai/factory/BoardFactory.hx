package ai.factory;

import ai.data.Cell;
import ai.data.Town;
import xa3.math.Pos;

class BoardFactory {
	
	public static function createBoard( boardWidth:Int, boardHeight:Int, positions:Array<Array<Pos>>, grid:Array<Array<Cell>>, towns:Array<Town> ) {
		return new ai.data.Board( boardWidth, boardHeight, positions, grid, towns );
	}
}