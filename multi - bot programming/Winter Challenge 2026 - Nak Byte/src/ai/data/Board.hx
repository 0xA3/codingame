package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;
import ya.Set;

class Board {
	
	public static inline var EMPTY = 0;
	public static inline var WALL = 1;
	public static inline var POWER_SOURCE = 2;
	public static inline var ME = 3;
	public static inline var OPPONENT = 4;

	public final width:Int;
	public final height:Int;
	public final positions:Array<Array<Pos>>;
	public final grid:Array<Array<Int>>;
	public final frameGrid:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;

	public function new(
		width:Int,
		height:Int,
		positions:Array<Array<Pos>>,
		grid:Array<Array<Int>>
	) {
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.grid = grid;

		frameGrid = [for( y in 0...height ) []];
		
		center = positions[int( height / 2 )][int( width / 2 )];
		halfWidth = int( width / 2 );
		thirdWidth = int( width / 3 );
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < width && y >= 0 && y < height;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= width || y < 0 || y >= height;
	

	public function centerDistance( pos:Pos ) {
		return center.manhattanDistance( pos );
	}

	public function createFrameGrid( powerSources:Array<Pos>, mySnakeBotIds:Set<Int>, snakebots:Map<Int, Snakebot> ) {
		for( y in 0...height ) for( x in 0...width ) frameGrid[y][x] = grid[y][x];
		for( powerSource in powerSources ) frameGrid[powerSource.y][powerSource.x] = POWER_SOURCE;
		for( snakebot in snakebots ) {
			for( pos in snakebot.bodyPositions ) {
				if( pos != null ) frameGrid[pos.y][pos.x] = mySnakeBotIds.contains( snakebot.id ) ? ME : OPPONENT;
			}
		}

		// printErr( frameGrid.map( row -> row.map( cell -> cell ).join( "" ) ).join( "\n" ) );
	}

	public function getPath( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return [];

		// final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		// if( solveResult.result == Solved ) {
		// 	return solveResult.path.map( p -> positions[p.y][p.x] );
		// }

		return [];
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		// final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		// if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return width + height;
	}


	// public function getNeighborPositions( pos:Pos ) return cells[pos].neighbors.map( cell -> cell.pos );
	// public function getNeighborCells( pos:Pos ) return cells[pos].neighbors;
}