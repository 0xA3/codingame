package ai.data;

import Std.int;
import astar.map2d.Map2D;
import xa3.math.Pos;

class Board {
	
	public final width:Int;
	public final height:Int;
	public final positions:Array<Array<Pos>>;
	public final map2D:Map2D;
	public final cells:Map<Pos, Cell>;
	public final tiles:Map<Pos, Int>;
	public final coverPositionSet:CoverPositionSet;

	public final centerPosition:Pos;

	public function new(
		width:Int,
		height:Int,
		positions:Array<Array<Pos>>,
		map2D:Map2D,
		cells:Map<Pos, Cell>,
		tiles:Map<Pos, Int>,
		coverPositionSet:CoverPositionSet
	) {
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.map2D = map2D;
		this.cells = cells;
		this.tiles = tiles;
		this.coverPositionSet = coverPositionSet;

		
		this.centerPosition = positions[int( height / 2 )][int( width / 2 )];
	}

	public function centerDistance( pos:Pos ) {
		return centerPosition.manhattanDistance( pos );
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return width + height;
	}

	public function getNextPos( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return start;

		final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		if( solveResult.result == Solved ) {
			if( solveResult.path.length > 1 ) {
				final nextPos = solveResult.path[1];
				return positions[nextPos.y][nextPos.x];
			}
		}
		
		return end;
	}

	public function getNeighborCells( pos:Pos ) {
		return cells[pos].neighbors;
	}
}