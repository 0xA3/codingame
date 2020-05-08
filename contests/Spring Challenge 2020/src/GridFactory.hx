import Cell;

using Lambda;

class GridFactory {
	
	public static function createGrid( width:Int, height:Int, lines:Array<String> ) {
		
		// convert lines to bool values - wall = false  floor = true
		final floors = lines.map( line -> line.split("").map( cell -> cell == " " ? true : false )).flatten();
		
		// set cells to wall or unknown
		final cells = floors.map( isFloor -> isFloor ? Unknown : Wall );
		
		// create grid
		final grid = new Grid( width, height, floors, cells );
		return grid;
	}
}