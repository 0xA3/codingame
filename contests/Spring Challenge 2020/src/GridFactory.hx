import Cell;
import astar.Graph;
import astar.MovementDirection;
import astar.types.Direction;

using Lambda;

class GridFactory {
	
	public static function createGrid( width:Int, height:Int, lines:Array<String> ) {
		
		// convert lines to bool values - wall = false  floor = true
		final floors = lines.map( line -> line.split("").map( cell -> cell == " " ? true : false )).flatten();
		
		final movementDirection = FourWay;
		final graph = new Graph( width, height, movementDirection, true );
		final worldMap = floors.map( b -> b ? 0 : 1 );
		final costs = [0 => [ N => 1., S => 1., W => 1., E => 1. ]];
		
		graph.setWorld( worldMap );
		graph.setCosts( costs );
		graph.configureCache( true, 40000 );

		// set cells to wall or unknown
		final cells = floors.map( isFloor -> isFloor ? Unknown : Wall );
		
		// create grid
		final grid = new Grid( width, height, floors, cells, graph );
		return grid;
	}

	static inline function getCellX( id:Int, width:Int ) return id % width;
	static inline function getCellY( id:Int, width:Int ) return Std.int( id / width );

}