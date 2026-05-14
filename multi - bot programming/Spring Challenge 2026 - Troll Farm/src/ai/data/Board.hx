package ai.data;

import CodinGame.printErr;
import Std.int;
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
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public function populateBoard( trees:Map<Pos, Tree>, trolls:Map<Int, Troll> ) {
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) currentBoard[y][x] = grid[y][x];
		// printErr( outputBoard( currentBoard ));

		turn++;
	}

	public inline function getCell( pos:Pos, futureTurns:Int ) {
		final cell = currentBoard[pos.y][pos.x];
		if( cell == GRASS ) return GRASS;
		if( cell == MY_SHACK ) return MY_SHACK;

		else return cell;
	}

	public function getDistance( start:Pos, end:Pos ) {
		final path = paths[pos2Index( start )][pos2Index( end )];
		return path.length - 1;
	}

	public function getPath( start:Pos, end:Pos ) {
		return paths[pos2Index( start )][pos2Index( end )];
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

	inline function pos2Index( pos:Pos ) return pos.y * boardWidth + pos.x;

}