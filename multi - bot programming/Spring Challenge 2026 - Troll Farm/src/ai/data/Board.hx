package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;
import ya.Set;

class Board {
	
	public static inline var GRASS = 0;
	public static inline var MY_SHACK = 1;
	public static inline var OPP_SHACK = 2;

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final emptyBoard:Array<Array<Int>>;
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
		marginGrid:Array<Array<Int>>
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.emptyBoard = marginGrid;

		currentBoard = [for( y in 0...boardHeight ) []];
		nextBoard = [for( y in 0...boardHeight ) []];
		
		halfWidth = int( boardWidth / 2 );
		thirdWidth = int( boardWidth / 3 );
		
		center = positions[int( boardHeight / 2 )][halfWidth];
	}

	public static function getCellType( s:String ) {
		switch( s ) {
			case "0": return MY_SHACK;
			case "1": return OPP_SHACK;
			default: return GRASS;
		}
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public function populateBoard( trees:Map<Pos, Tree>, trolls:Map<Int, Troll> ) {
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) currentBoard[y][x] = emptyBoard[y][x];
		// printErr( outputBoard( currentBoard ));

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

			neighbors.push( neighborPosition );
		}

		return neighbors;
	}

	public inline function getCell( pos:Pos, futureTurns:Int ) {
		final cell = currentBoard[pos.y][pos.x];
		if( cell == GRASS ) return GRASS;
		if( cell == MY_SHACK ) return MY_SHACK;

		else return cell;
	}

	public function getDistance( start:Pos, end:Pos ) {
		if( start.manhattanDistance( end ) <= 1 ) return 1;
		return start.manhattanDistance( end );
	}

	public function outputBoard( board:Array<Array<Int>> ) {
		final output = [for( y in 0...boardHeight )
			[for( x in 0...boardWidth ) {
				final cell = board[y][x];
				switch( cell ) {
					case GRASS: ".";
					case MY_SHACK: "0";
					case OPP_SHACK: "1";
					default: '$cell';
				}
			}].join( "" )
		];
		
		return output.join( "\n" );
	}

	public function previewNextBoard() {
		for( y in 0...boardHeight ) for( x in 0...boardWidth ) nextBoard[y][x] = emptyBoard[y][x];

		return outputBoard( nextBoard );
	}
}