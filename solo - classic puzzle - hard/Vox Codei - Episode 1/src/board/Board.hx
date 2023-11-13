package board;

import CodinGame.printErr;
import Constants;
import board.GetNodePositions.getNodePositions;
import data.Bomb;
import data.Pos;
import haxe.ds.ReadOnlyArray;

class Board {
	
	public final width:Int;
	public final height:Int;
	final privateGrid:Array<Array<String>>;
	public var grid(get, null):ReadOnlyArray<ReadOnlyArray<String>>;
	function get_grid() return privateGrid;

	final privateSurveillanceNodes:Array<Pos>;
	public var surveillanceNodes(get, null):ReadOnlyArray<Pos>;
	function get_surveillanceNodes() return privateSurveillanceNodes;

	final privateBombs:Array<Bomb> = [];
	public var bombs(get, null):ReadOnlyArray<Bomb>;
	function get_bombs() return privateBombs;

	public function new( width:Int, height:Int, grid:Array<Array<String>>, surveillanceNodes:Array<Pos>, bombs:Array<Bomb> ) {
		this.width = width;
		this.height = height;
		privateGrid = grid;
		this.privateSurveillanceNodes = surveillanceNodes;
		this.privateBombs = bombs;
	}

	public static function create( width:Int, height:Int, grid:Array<Array<String>> ) {
		var privateSurveillanceNodes:Array<Pos> = [for( y in 0...height ) for( x in 0...width ) if( grid[y][x] == SURVELLANCE_NODE ) {x: x, y: y} ];
		return new Board( width, height, grid, privateSurveillanceNodes, [] );
	}
	
	public function next( bombX = -1, bombY = -1 ) {
		final nextGrid = privateGrid.map( row -> row.copy() );
		final nextBombs:Array<Bomb> = [];
		if( bombX != -1 ) {
			final nextBomb:Bomb = { x: bombX, y: bombY, time: 2 }
			nextBombs.push( nextBomb );
			nextGrid[bombY][bombX] = BOMB;
		}

		for( bomb in bombs ) {
			// trace( 'bomb ${bomb.x}:${bomb.y} time ${bomb.time}' );
			if( bomb.time > 0 ) {
				nextBombs.push({ x: bomb.x, y: bomb.y, time: bomb.time - 1 });
			} else {
				triggerBomb( bomb.x, bomb.y, nextGrid );
			}
		}

		final nextSurveillanceNodes = getNodePositions( nextGrid, SURVELLANCE_NODE );

		return new Board( width, height, nextGrid, nextSurveillanceNodes, nextBombs );
	}

	function triggerBomb( x:Int, y:Int, nextGrid:Array<Array<String>> ) {
		nextGrid[y][x] = PREVIOUS_BOMB;
		for( distance in 1...BOMB_RANGE + 1 ) {
			final top = y - distance;
			if( top >= 0 ) {
				final cell = nextGrid[top][x];
				if( cell == PASSIVE_NODE ) break;
				if( cell == SURVELLANCE_NODE ) nextGrid[top][x] = EMPTY;
				else if( cell == BOMB ) triggerBomb( x, top, nextGrid );
			}
		}
		for( distance in 1...BOMB_RANGE + 1 ) {
			final left = x - distance;
			if( left >= 0 ) {
				final cell = nextGrid[y][left];
				if( cell == PASSIVE_NODE ) break;
				if( cell == SURVELLANCE_NODE ) nextGrid[y][left] = EMPTY;
				else if( cell == BOMB ) triggerBomb( left, y, nextGrid );
			}
		}
		for( distance in 1...BOMB_RANGE + 1 ) {
			final bottom = y + distance;
			if( bottom < height ) {
				final cell = nextGrid[bottom][x];
				if( cell == PASSIVE_NODE ) break;
				if( cell == SURVELLANCE_NODE ) nextGrid[bottom][x] = EMPTY;
				else if( cell == BOMB ) triggerBomb( x, bottom, nextGrid );
			}
		}
		for( distance in 1...BOMB_RANGE + 1 ) {
			final right = x + distance;
			if( right < width ) {
				final cell = nextGrid[y][right];
				if( cell == PASSIVE_NODE ) break;
				if( cell == SURVELLANCE_NODE ) nextGrid[y][right] = EMPTY;
				else if( cell == BOMB ) triggerBomb( right, y, nextGrid );
			}
		}
	}
}