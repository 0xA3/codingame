package board;

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
	
	public function placeBomb( bomb:Bomb ) {
		privateBombs.push( bomb );
		privateGrid[bomb.y][bomb.x] = BOMB;
	}

	public function next() {
		final nextGrid = privateGrid.map( row -> row.copy() );
		final nextBombs:Array<Bomb> = [];
		for( bomb in bombs ) {
			if( bomb.time > 0 ) {
				nextBombs.push({ x: bomb.x, y: bomb.y, time: bomb.time - 1 });
			} else {
				nextGrid[bomb.y][bomb.x] = EMPTY;
				for( distance in 1...BOMB_RANGE + 1 ) {
					final top = bomb.y - distance;
					if( top >= 0 ) {
						if( nextGrid[top][bomb.x] == PASSIVE_NODE ) break;
						if( nextGrid[top][bomb.x] == SURVELLANCE_NODE ) {
							nextGrid[top][bomb.x] = EMPTY;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final left = bomb.x - distance;
					if( left >= 0 ) {
						if( nextGrid[bomb.y][left] == PASSIVE_NODE ) break;
						if( nextGrid[bomb.y][left] == SURVELLANCE_NODE ) {
							nextGrid[bomb.y][left] = EMPTY;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final bottom = bomb.y + distance;
					if( bottom < height ) {
						if( nextGrid[bottom][bomb.x] == PASSIVE_NODE ) break;
						if( nextGrid[bottom][bomb.x] == SURVELLANCE_NODE ) {
							nextGrid[bottom][bomb.x] = EMPTY;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final right = bomb.x + distance;
					if( right < width ) {
						if( nextGrid[bomb.y][right] == PASSIVE_NODE ) break;
						if( nextGrid[bomb.y][right] == SURVELLANCE_NODE ) {
							nextGrid[bomb.y][right] = EMPTY;
						}
					}
				}
			}
		}

		final nextSurveillanceNodes = getNodePositions( nextGrid, SURVELLANCE_NODE );

		return new Board( width, height, nextGrid, nextSurveillanceNodes, nextBombs );
	}
}