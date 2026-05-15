package ai.data;

import CodinGame.printErr;
import Std.int;
import astar.map2d.Map2D;
import astar.map2d.types.MovementDirection;
import xa3.math.Pos;
import ya.Set;

class Board {
	
	public static inline var GRASS = 0;
	public static inline var WATER = 1;
	public static inline var ROCK = 2;
	public static inline var IRON = 3;
	public static inline var MY_SHACK = 4;
	public static inline var OPP_SHACK = 5;

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final paths:Array<Array<Array<Pos>>>;
	public final grid:Array<Array<Int>>;
	public final myShack:Pos;
	public final oppShack:Pos;

	public final ironNeighbors:Array<Pos> = [];
	public final waterNeighbors:Array<Pos> = [];
	
	final map2d:Map2D;

	public final currentBoard:Array<Array<Int>>;
	
	public final nextBoard:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	public final neighborOffsets = Pos.createNeighborOffsets();

	var turn = 0;

	public function new(
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		grid:Array<Array<Int>>,
		paths:Array<Array<Array<Pos>>>,
		myShack:Pos,
		oppShack:Pos
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.grid = grid;
		this.paths = paths;
		this.myShack = myShack;
		this.oppShack = oppShack;

		currentBoard = [for( y in 0...boardHeight ) []];
		nextBoard = [for( y in 0...boardHeight ) []];
		
		halfWidth = int( boardWidth / 2 );
		thirdWidth = int( boardWidth / 3 );
		
		center = positions[int( boardHeight / 2 )][halfWidth];

		final movementDirection = FourWay;
		
		map2d = new Map2D( boardWidth, boardHeight, movementDirection );
		final costs = [0 => Map2D.defaultCosts];
		
		map2d.setMap( [for( y in 0...boardHeight ) for( x in 0...boardWidth ) grid[y][x]] );
		map2d.setCosts( costs );
		map2d.configureCache( true, 1024 );
	}

	public function addWaterAndIronNeighbors() {
		for( y in 0...boardHeight ) {
			for( x in 0...boardWidth ) {
				final pos = positions[y][x];
				var isIronNeighbor = false;
				var isWaterNeighbor = false;
				final neighbors = getAllNeighbors( pos );
				for( neighbor in neighbors ) {
					if( getCell( neighbor ) == Board.IRON ) isIronNeighbor = true;
					if( getCell( neighbor ) == Board.WATER ) isWaterNeighbor = true;
				}
				if( isIronNeighbor ) ironNeighbors.push( pos );
				if( isWaterNeighbor ) waterNeighbors.push( pos );
			}
		}
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public inline function getCell( pos:Pos ) {
		final cell = currentBoard[pos.y][pos.x];

		return cell;
	}

	public function getWalkableNeighbors( pos:Pos ) {
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final neighborX = pos.x + neighborOffset.x;
			final neighborY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( neighborX, neighborY ) ) continue;
			
			final neighbor = positions[neighborY][neighborX];
			final cell = getCell( neighbor );
			if( cell == WATER || cell == ROCK || cell == IRON ) continue;
			neighbors.push( neighbor );
		}
		return neighbors;
	}

	public function getAllNeighbors( pos:Pos ) {
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final neighborX = pos.x + neighborOffset.x;
			final neighborY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( neighborX, neighborY ) ) continue;
			final neighbor = positions[neighborY][neighborX];
			neighbors.push( neighbor );
		}
		return neighbors;
	}

	public function getDistance( startPos:Pos, endPos:Pos ) {
		final path = getPath( startPos, endPos );
		return path.length - 1;
	}

	public function getPath( startPos:Pos, endPos:Pos ) {
		final startIndex = pos2Index( startPos );
		final endIndex = pos2Index( endPos );
		
		if( paths[startIndex][endIndex].length == 0 ) {
			if( startIndex == endIndex ) {
				final path = [startPos];
				paths[startIndex][endIndex] = path;
				// printErr( 'getPath $startPos -> $endPos: $path' );
				return path;
			}
			
			final solution = map2d.solve( startPos.x, startPos.y, endPos.x, endPos.y );
			
			if( solution.result == Solved ) {
				final path = solution.path.map( point2D -> positions[point2D.y][point2D.x] );
				paths[startIndex][endIndex] = path;
				
				final reversePath = path.copy();
				reversePath.reverse();
				paths[endIndex][startIndex] = reversePath;
				
				// printErr( 'new path $startPos -> $endPos: $path' );
				return path;
			
			} else {
				// printErr( 'getPath $startPos -> $endPos: notfound' );
				return [];
			}
		}

		final path = paths[startIndex][endIndex];
		// printErr( 'getPath $startPos -> $endPos: $path' );
		return path;
	}

	public function outputBoard( board:Array<Array<Int>> ) {
		final output = [for( y in 0...boardHeight )
			[for( x in 0...boardWidth ) {
				final cell = board[y][x];
				switch( cell ) {
					case WATER: return "~";
					case ROCK: return "#";
					case IRON: return "+";
					case MY_SHACK: return "0";
					case OPP_SHACK: return "1";
					default: return ".";
				}
			}].join( "" )
		];
		
		return output.join( "\n" );
	}

	public function previewNextBoard() {
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) nextBoard[y][x] = grid[y][x];

		return outputBoard( nextBoard );
	}

	inline function index2Pos( index:Int ) return positions[int( index / boardWidth )][index % boardWidth];
	inline function pos2Index( pos:Pos ) return pos.y * boardWidth + pos.x;

}