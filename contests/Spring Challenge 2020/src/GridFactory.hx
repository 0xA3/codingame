import Cell;

using Lambda;

class GridFactory {
	
	public static function createGrid( width:Int, height:Int, lines:Array<String> ) {
		
		final floors = lines.map( line -> line.split("").map( cell -> cell == " " ? true : false )).flatten();
		final cellContents = floors.map( isFloor -> isFloor ? Unknown : Wall );
		final cells = cellContents.mapi(( i, cellContent ) -> new Cell( i % width, Std.int( i / width ), cellContent ));
		final grid = new Grid( width, height, floors, cells );
		return grid;
	}
}