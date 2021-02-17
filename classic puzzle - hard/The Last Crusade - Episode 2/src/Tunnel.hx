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

	public function getNextNode( current:Node ) {
		
		final nextIndy = incrementLocation( current.indy );
		final nextRocks = current.rocks.map( rock -> incrementLocation( rock ));
		
		final rollingNextRocks = nextRocks.filter( rock -> rock != noLocation ); // remove destroyed rocks
		removeRockRockCollision( rollingNextRocks );
		
		var isCrushed = checkIndyRockCollision( nextIndy, rollingNextRocks );
		final nextAliveIndy = isCrushed ? noLocation : nextIndy;
		final nextNode:Node = { parent: current, indy: nextAliveIndy, rocks: nextRocks, tile: cells[nextIndy.index], index: nextAliveIndy.index, diff: 0 };

		return nextNode;
	}

	public function incrementLocation( location:Location ) {
		
		final index = location.index;
		final pos = location.pos;
		final tile = cells[index];
		final delta = tileMovements[tile][pos];
		// trace( 'index $index pos $pos tile $tile delta $delta' );
		final x = getX( index );
		if(( x == 0 && delta[0] == -1 )||( x == width - 1 && delta[0] == 1 )) return noLocation;
		
		final nextIndex = index + delta[0] + delta[1] * width;
		if( nextIndex == index ) return noLocation;
		if( nextIndex >= cells.length ) return noLocation;
		
		final nextPos = directions[tile][pos];
		final nextLocation:Location = { index: nextIndex, pos: nextPos };

		return nextLocation;
	}

	function removeRockRockCollision( rocks:Array<Location> ) {
		rocks.sort(( a, b ) -> b.index - a.index );
		var i = rocks.length - 1;
		while( i > 0 ) {
			final startIndex = rocks[i].index;
			i--;
			if( rocks[i].index == startIndex ) {
				rocks.remove( rocks[i + 1] );
				while( rocks[i].index == startIndex ) {
					rocks.remove( rocks[i] );
					i--;
				}
			}
		}
	}
	
	function checkIndyRockCollision( indy:Location, rocks:Array<Location >) {
		for( rock in rocks ) if( indy.index == rock.index) return true;
		return false;
	}

	public function getChildNodes( parent:Node, nextNode:Node ) {
		
		final indyIndex = nextNode.indy.index;
		final indyPos = nextNode.indy.pos;
		final indyRotationTiles = locked[indyIndex] ? [cells[indyIndex]] : tileRotations[cells[indyIndex]];
		final validIndyRotationTiles = indyRotationTiles.filter( rotationTile -> { // filter for rotations that can be entered
			final delta = tileMovements[rotationTile][indyPos];
			return delta[0] != 0 || delta[1] != 0;
		});
		
		final childNodes = [];
		for( rotationTile in validIndyRotationTiles ) {
			final node = createNode( parent, nextNode.indy, nextNode.rocks, indyIndex, indyPos, rotationTile );
			childNodes.push( node );
		}

		for( rock in nextNode.rocks ) {
			final rockIndex = rock.index;
			final rockPos = rock.pos;
			final rockRotationTiles = locked[rockIndex] ? [cells[rockIndex]] : tileRotations[cells[rockIndex]];
	
			for( rotationTile in rockRotationTiles ) {
				final node = createNode( parent, nextNode.indy, nextNode.rocks, rockIndex, rockPos, rotationTile );
				childNodes.push( node );
			}
		}

		return childNodes;
	}

	function createNode( parent:Node, indy:Location, rocks:Array<Location>, index:Int, pos:Int, tile:Int ) {
		
		final srcTile = cells[index];
		final diff = tileRotations[srcTile].indexOf( tile );
		final modDiff = (( diff + 1 ) % 4 ) - 1;
		final node:Node = { parent: parent, indy: indy, rocks:rocks, index: index, tile: tile, diff: modDiff };
		
		return node;
	}

	public function getNextAction( path:Path ) {
		trace( "\n" + path.map( node -> '${node.index} tile ${node.tile} diff ${node.diff}').join( "\n" ));
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