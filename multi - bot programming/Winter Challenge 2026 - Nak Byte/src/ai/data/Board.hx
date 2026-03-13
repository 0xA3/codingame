package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;
import ya.Set;

class Board {
	
	public static inline var EMPTY = 0;
	public static inline var WALL = 100;
	public static inline var POWER_SOURCE = 200;

	public final gridWidth:Int;
	public final gridHeight:Int;
	public final marginX:Int;
	public final marginY:Int;
	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final emptyBoard:Array<Array<Int>>;
	public final currentBoard:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	final neighborOffsets = Pos.createNeighborOffsets();

	// final neighborsCache:Map<Pos, Array<Pos>> = [];

	public function new(
		gridWidth:Int,
		gridHeight:Int,
		marginX:Int,
		marginY:Int,
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		marginGrid:Array<Array<Int>>
	) {
		this.gridWidth = gridWidth;
		this.gridHeight = gridHeight;
		this.marginX = marginX;
		this.marginY = marginY;
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.emptyBoard = marginGrid;

		currentBoard = [for( y in 0...boardHeight ) []];
		
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
		// neighborsCache.clear();
		
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) currentBoard[y][x] = emptyBoard[y][x];
		for( powerSource in powerSources ) currentBoard[powerSource.y][powerSource.x] = POWER_SOURCE;
		for( snakebot in snakebots ) {
			for( i in 0...snakebot.bodyPositions.length ) {// ignore last element as it moves 1 cell forward
				final pos = snakebot.bodyPositions[i];
				currentBoard[pos.y][pos.x] = i + 1;
			}
		}
		// outputBoard();
	}

	public function getNeighbors( pos:Pos ) {
		// if( neighborsCache.exists( pos )) return neighborsCache[pos];
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( nextX, nextY ) ) continue;

			final neighborPosition = positions[nextY][nextX];
			final cell = currentBoard[neighborPosition.y][neighborPosition.x];
			if( cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}
		// neighborsCache.set( pos, neighbors );

		return neighbors;
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		// final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		// if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return boardWidth + boardHeight;
	}

	public function outputBoard() {
		for( y in marginY...marginY + gridHeight ) {
			final line = [for( x in marginX...marginX + gridWidth ) {
				final cell = currentBoard[y][x];
				switch( cell ) {
					case EMPTY: ".";
					case WALL: "#";
					case POWER_SOURCE: "P";
					default: '$cell';
				}
			}].join( "" );
			printErr( line );
		}
	}
}