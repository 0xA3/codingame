import BreadthFirstSearch.Path;
import Location;
import Std.int;
import Tiles;
import Transformations;

class Tunnel {
	
	public static final noLocation:Location = { index: -1, pos: -1 };

	public final cells:Array<Int>;
	public final locked:Array<Bool>;
	public final width:Int;
	
	public function new( cells:Array<Int>, locked:Array<Bool>, width:Int ) {
		this.cells = cells;
		this.locked = locked;
		this.width = width;
	}

	public function getNextCellLocation( current:Node, rocks:Array<Location> ) {
		
		final index = current.index;
		final pos = current.pos;
		final tile = current.tile;

		final delta = tileMovements[tile][pos];
		
		final x = getX( index );
		if(( x == 0 && delta[0] == -1 )||( x == width - 1 && delta[0] == 1 )) return noLocation;
		
		final nextIndex = index + delta[0] + delta[1] * width;
		if( nextIndex == index ) return noLocation;
		if( nextIndex >= cells.length ) return noLocation;
		
		final nextPos = directions[tile][pos];
		final nextLocation:Location = { index: nextIndex, pos: nextPos };

		return nextLocation;
	}

	public function getNextCellRotations( nextLocation:Location ) {
		
		final rotationTiles = locked[nextLocation.index] ? [cells[nextLocation.index]] : tileRotations[cells[nextLocation.index]];
		final validRotationTiles = rotationTiles.filter( tile -> { // filter for rotations that can be entered
			final delta = tileMovements[tile][nextLocation.pos];
			return delta[0] != 0 || delta[1] != 0;
		});

		return validRotationTiles;
	}		
	
	public function getChildNodes( parent:Node, nextLocation:Location, rotationTiles:Array<Int> ) {
		
		final childNodes = [];
		for( tile in rotationTiles ) {
			final srcTile = cells[nextLocation.index];
			final diff = tileRotations[srcTile].indexOf( tile );
			final modDiff = (( diff + 1 ) % 4 ) - 1;
			final node:Node = { parent: parent, index: nextLocation.index, pos: nextLocation.pos, tile: tile, diff: modDiff };
			childNodes.push( node );
		}

		return childNodes;
	}

	public function getNextAction( path:Path ) {
		// trace( "\n" + path.map( node -> '${node.index} tile ${node.tile} diff ${node.diff}').join( "\n" ));
		var action = "";
		for( node in path ) {
			final index = node.index;
			final diff = node.diff;
			if( diff < 0 ) {
				turnTileLeft( index, node.tile, diff  );
				action = xy( index ) + ' LEFT';
				break;
			} else if( diff > 0 ) {
				turnTileRight( index, node.tile, diff );
				action = xy( index ) + ' RIGHT';
				break;
			} else action = "WAIT";
		}
		return action;
	}
	
	function turnTileLeft( index:Int, tile:Int, diff:Int ) {
		final currentTile = cells[index];
		final tiles = tileRotations[currentTile];
		// trace( 'tile $index (${cells[index]}) turn left -> ${tiles[tiles.length - 1]}' );
		cells[index] = tiles[tiles.length - 1]; // last tile of rotations
	}

	function turnTileRight( index:Int, tile:Int, diff:Int ) {
		final currentTile = cells[index];
		final tiles = tileRotations[currentTile];
		// printErr( 'tile $index (${tunnel.cells[index]}) turn right -> ${tiles[1]}' );
		cells[index] = tiles[1]; // next tile of rotations
	}


	public inline function getX( id:Int ) return id % width;
	public inline function getY( id:Int ) return int( id / width );
	inline function getIndex( x:Int, y:Int ) return y * width + x;
	inline function xy( index:Int ) return '${getX( index)} ${getY( index)}';

	public function toString() {
		var output = "";
		final height = int( cells.length / width );
		for( y in 0...height ) {
			for( i in 0...3 ) {
				for( x in 0...width ) {
					final cell = cells[getIndex(x, y)];
					output += tiles[cell][i];
				}
				output += "\n";
			}
		}
		return output;
	}

}