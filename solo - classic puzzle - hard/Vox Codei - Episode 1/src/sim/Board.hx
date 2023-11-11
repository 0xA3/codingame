package sim;

import Constants;
import data.Bomb;
import data.Pos;

class Board {
	
	public final width:Int;
	public final height:Int;
	final privateGrid:Array<Array<Int>>;
	public var grid(get, null):haxe.ds.ReadOnlyArray<haxe.ds.ReadOnlyArray<Int>>;
	function get_grid() return privateGrid;

	public final outputGrid:Array<Array<String>>;
	public var numSurveillanceNodes:Int;
	public final bombs:Array<Bomb> = [];

	public function new( width:Int, height:Int, grid:Array<Array<Int>>, numSurveillanceNodes:Int ) {
		this.width = width;
		this.height = height;
		privateGrid = grid;
		this.numSurveillanceNodes = numSurveillanceNodes;

		outputGrid = [for( y in 0...height ) [for( x in 0...width ) ""]];
	}

	public static function create( width:Int, height:Int, rows:Array<String> ) {
		final grid = [for( _ in 0...height ) [for( _ in 0...width ) 0]];
		final inputGrid = rows.map( row -> row.split( "" ));
		
		var numSurveillanceNodes = 0;
		for( y in 0...inputGrid.length ) {
			final row = inputGrid[y];
			for( x in 0...row.length ) {
				final cell = row[x];
				switch cell {
					case "@":
						grid[y][x] = SURVELLANCE_NODE;
						numSurveillanceNodes++;
					case "#": grid[y][x] = PASSIVE_NODE;
					default: // no-op
				}
			}
		}
		
		return new Board( width, height, grid, numSurveillanceNodes );
	}
	
	public function getNodePositions( nodeType:Int ) {
		final positions = [for( y in 0...grid.length ) for( x in 0...grid[y].length ) if( grid[y][x] == nodeType ) {
			final pos:Pos = { x: x, y: y }
			pos;
		}];
		
		return positions;
	}

	public function updateBombTime() {
		for( bomb in bombs ) bomb.time--;
	}

	public function cleanUp() {
		for( i in -bombs.length + 1...1 ) {
			final bomb = bombs[-i];
			if( bomb.time == 0 ) {
				bombs.remove( bomb );
				for( distance in 1...BOMB_RANGE + 1 ) {
					final top = bomb.y - distance;
					if( top >= 0 ) {
						if( privateGrid[top][bomb.x] == PASSIVE_NODE ) break;
						if( privateGrid[top][bomb.x] == SURVELLANCE_NODE ) {
							privateGrid[top][bomb.x] = EMPTY;
							numSurveillanceNodes--;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final left = bomb.x - distance;
					if( left >= 0 ) {
						if( privateGrid[bomb.y][left] == PASSIVE_NODE ) break;
						if( privateGrid[bomb.y][left] == SURVELLANCE_NODE ) {
							privateGrid[bomb.y][left] = EMPTY;
							numSurveillanceNodes--;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final bottom = bomb.y + distance;
					if( bottom < height ) {
						if( privateGrid[bottom][bomb.x] == PASSIVE_NODE ) break;
						if( privateGrid[bottom][bomb.x] == SURVELLANCE_NODE ) {
							privateGrid[bottom][bomb.x] = EMPTY;
							numSurveillanceNodes--;
						}
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final right = bomb.x + distance;
					if( right < width ) {
						if( privateGrid[bomb.y][right] == PASSIVE_NODE ) break;
						if( privateGrid[bomb.y][right] == SURVELLANCE_NODE ) {
							privateGrid[bomb.y][right] = EMPTY;
							numSurveillanceNodes--;
						}
					}
				}
			}
		}
	}

	public function draw() {
		clearGrid();
		for( y in 0...privateGrid.length ) {
			for( x in 0...privateGrid[y].length ) {
				outputGrid[y][x] = switch privateGrid[y][x] {
					case EMPTY: "·";
					case SURVELLANCE_NODE: "@";
					case PASSIVE_NODE: "#";
					default: "";
				}
			}
		}
		for( bomb in bombs ) {
			outputGrid[bomb.y][bomb.x] = bomb.time == 0 ? "*" : '${bomb.time}';
			if( bomb.time == 0 ) {
				for( distance in 1...BOMB_RANGE + 1 ) {
					final top = bomb.y - distance;
					if( top >= 0 ) {
						if( privateGrid[top][bomb.x] == PASSIVE_NODE ) break;
						outputGrid[top][bomb.x] = "*";
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final left = bomb.x - distance;
					if( left >= 0 ) {
						if( privateGrid[bomb.y][left] == PASSIVE_NODE ) break;
						outputGrid[bomb.y][left] = "*";
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final bottom = bomb.y + distance;
					if( bottom < height ) {
						if( privateGrid[bottom][bomb.x] == PASSIVE_NODE ) break;
						outputGrid[bottom][bomb.x] = "*";
					}
				}
				for( distance in 1...BOMB_RANGE + 1 ) {
					final right = bomb.x + distance;
					if( right < width ) {
						if( privateGrid[bomb.y][right] == PASSIVE_NODE ) break;
						outputGrid[bomb.y][right] = "*";
					}
				}
			}
		}
		return outputGrid.map( row -> row.join("")).join("\n" );
	}

	function clearGrid() for( y in 0...height ) for( x in 0...width ) outputGrid[y][x] = "·";
}