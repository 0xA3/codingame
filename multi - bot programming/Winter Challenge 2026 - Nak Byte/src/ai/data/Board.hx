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

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final marginGrid:Array<Array<Int>>;
	public final frameGrid:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	final neighborOffsets = Pos.createNeighborOffsets();

	final neighborsCache:Map<Pos, Array<Pos>> = [];

	public function new(
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		marginGrid:Array<Array<Int>>
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.marginGrid = marginGrid;

		frameGrid = [for( y in 0...boardHeight ) []];
		
		center = positions[int( boardHeight / 2 )][int( boardWidth / 2 )];
		halfWidth = int( boardWidth / 2 );
		thirdWidth = int( boardWidth / 3 );
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	

	public function centerDistance( pos:Pos ) {
		return center.manhattanDistance( pos );
	}

	public function populateGrid( powerSources:Array<Pos>, mySnakeBotIds:Set<Int>, snakebots:Map<Int, Snakebot> ) {
		neighborsCache.clear();
		
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) frameGrid[y][x] = marginGrid[y][x];
		for( powerSource in powerSources ) frameGrid[powerSource.y][powerSource.x] = POWER_SOURCE;
		for( snakebot in snakebots ) {
			for( i in 0...snakebot.bodyPositions.length - 1 ) {// ignore last element as it moves 1 cell forward
				final pos = snakebot.bodyPositions[i];
				frameGrid[pos.y][pos.x] = mySnakeBotIds.contains( snakebot.id ) ? ME : OPPONENT;
			}
		}
		// printErr( frameGrid.map( row -> row.map( cell -> cell ).join( "" ) ).join( "\n" ) );
	}

	public function getNeighbors( pos:Pos ) {
		if( neighborsCache.exists( pos )) return neighborsCache[pos];
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( nextX, nextY ) ) continue;

			final neighborPosition = positions[nextY][nextX];
			final cell = marginGrid[neighborPosition.y][neighborPosition.x];
			if( cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}
		neighborsCache.set( pos, neighbors );

		return neighbors;
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		// final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		// if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return boardWidth + boardHeight;
	}


	// public function getNeighborPositions( pos:Pos ) return cells[pos].neighbors.map( cell -> cell.pos );
	// public function getNeighborCells( pos:Pos ) return cells[pos].neighbors;
}