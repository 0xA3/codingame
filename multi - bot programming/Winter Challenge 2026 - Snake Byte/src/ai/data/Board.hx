package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;
import ya.Set;

class Board {
	
	public static inline var EMPTY = 0;
	public static inline var WALL = 100;
	public static inline var POWER_SOURCE = 200;

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final marginX:Int;
	public final marginY:Int;
	public final marginBoardWidth:Int;
	public final marginBoardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final emptyBoard:Array<Array<Int>>;
	public final currentBoard:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	public final neighborOffsets = Pos.createNeighborOffsets();

	var turn = 0;

	public function new(
		boardWidth:Int,
		boardHeight:Int,
		marginX:Int,
		marginY:Int,
		marginBoardWidth:Int,
		marginBoardHeight:Int,
		positions:Array<Array<Pos>>,
		marginGrid:Array<Array<Int>>
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.marginX = marginX;
		this.marginY = marginY;
		this.marginBoardWidth = marginBoardWidth;
		this.marginBoardHeight = marginBoardHeight;
		this.positions = positions;
		this.emptyBoard = marginGrid;

		currentBoard = [for( y in 0...marginBoardHeight ) []];
		
		center = positions[int( marginBoardHeight / 2 )][int( marginBoardWidth / 2 )];
		halfWidth = int( marginBoardWidth / 2 );
		thirdWidth = int( marginBoardWidth / 3 );
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= marginX && x < marginX + boardWidth && y >= 0 && y < marginY + boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < marginX || x >= marginX + boardWidth || y < 0 || y >= marginY + boardHeight;
	public function checkOutsideMarginBoard( x:Int, y:Int ) return x < 0 || x >= marginBoardWidth || y < 0 || y >= marginY + boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public function populateBoard( powerSources:Array<Pos>, mySnakeBotIds:Set<Int>, snakebots:Map<Int, Snakebot> ) {
		
		for( y in 0...marginBoardHeight ) for( x in 0...marginBoardWidth ) currentBoard[y][x] = emptyBoard[y][x];
		for( powerSource in powerSources ) currentBoard[powerSource.y][powerSource.x] = POWER_SOURCE;
		for( snakebot in snakebots ) {
			final length = snakebot.bodyPositions.length;
			for( i in 0...length ) {
				final pos = snakebot.bodyPositions[i];
				currentBoard[pos.y][pos.x] = length - i;
			}
		}
		// outputBoard();

		turn++;
	}

	public function getNeighbors( pos:Pos, depth:Int ) {
		final neighbors = [];
		
		for( neighborOffset in neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( nextX, nextY ) ) continue;

			final neighborPosition = positions[nextY][nextX];
			final cell = getCell( neighborPosition, depth );

			if( cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}

		return neighbors;
	}

	public function getCell( pos:Pos, futureTurns:Int ) {
		final cell = currentBoard[pos.y][pos.x];
		if( cell == EMPTY ) return EMPTY;
		if( cell == POWER_SOURCE ) return POWER_SOURCE;
		if( cell == WALL ) return WALL;
		else return cell - futureTurns;
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;

		// final solveResult = map2D.solve( start.x, start.y, end.x, end.y );
		// if( solveResult.result == Solved ) return solveResult.path.length - 1;

		return marginBoardWidth + marginBoardHeight;
	}

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';

	public function outputBoard() {
		for( y in marginY...marginY + boardHeight ) {
			final line = [for( x in marginX...marginX + boardWidth ) {
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