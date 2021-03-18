import BreadthFirstSearch.Path;
import Std.int;
import data.Location;
import data.Node;
import data.Tiles;
import data.TilesUtf8;
import data.Transformations;

using Lambda;

class Tunnel {
	
	public static final noLocation:Location = { index: -1, pos: -1 };

	public final locked:Array<Bool>;
	public final width:Int;
	
	public function new( locked:Array<Bool>, width:Int ) {
		this.locked = locked;
		this.width = width;
	}

	public function getNextNode( current:Node ):Node {
		
		var isCrushed = checkIndyRockCollision( current.indy, current.rocks );
		// if( isCrushed ) trace( 'IndyRock collision at ${current.indy.index}' );
		if( isCrushed ) return { parent: current, cells: current.cells, indy: noLocation, rocks: current.rocks, tile: 0, index: -1, diff: 0 };
		
		removeCollidedRocks( current.rocks );
		
		final cells = current.cells;
		final nextIndy = incrementLocation( cells, current.indy );
		final nextRocks = current.rocks.map( rock -> incrementLocation( cells, rock ));
		final existingNextRocks = nextRocks.filter( rock -> rock != noLocation ); // remove destroyed rocks

		return { parent: current, cells: current.cells, indy: nextIndy, rocks: existingNextRocks, tile: cells[nextIndy.index], index: nextIndy.index, diff: 0 };
	}

	public function incrementLocation( cells:Array<Int>, location:Location ) {
		
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

	function removeCollidedRocks( rocks:Array<Location> ) {
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

	public function getChildNodes( current:Node, nextNode:Node ) {

		final currentRockIndices = current.rocks.map( rock -> rock.index );

		final cells = nextNode.cells;
		final indyIndex = nextNode.indy.index;
		final indyPos = nextNode.indy.pos;
		final indyRotationTiles = locked[indyIndex] ? [cells[indyIndex]] // don't rotate locked tiles
			: currentRockIndices.contains( indyIndex ) ? [cells[indyIndex]] // don't rotate tiles of rocks
			: tileRotations[cells[indyIndex]];
		final validIndyRotationTiles = indyRotationTiles.filter( rotationTile -> { // filter for rotations that can be entered
			final delta = tileMovements[rotationTile][indyPos];
			return delta[0] != 0 || delta[1] != 0;
		});
		
		final childNodes = [];
		for( rotationTile in validIndyRotationTiles ) {
			final node = createNode( current, nextNode.indy, nextNode.rocks, indyIndex, indyPos, rotationTile );
			childNodes.push( node );
		}

		final tileIndices = [indyIndex];

		for( rock in nextNode.rocks ) {
			final rockIndex = rock.index;
			if( !tileIndices.contains( rockIndex )) { // check if the tile is already rotated
				tileIndices.push( rockIndex );
				final rockPos = rock.pos;
			
				final rockRotationTiles = locked[rockIndex] ? [cells[rockIndex]] // don't rotate locked tiles
					: rockIndex == indyIndex ? [cells[rockIndex]] // don't rotate indy tile
					: currentRockIndices.contains( rockIndex ) ? [cells[rockIndex]] // don't rotate tiles of other rocks
					: tileRotations[cells[rockIndex]];
		
				for( rotationTile in rockRotationTiles ) {
					final node = createNode( current, nextNode.indy, nextNode.rocks, rockIndex, rockPos, rotationTile );
					childNodes.push( node );
				}
			}
		}

		return childNodes;
	}

	function createNode( parent:Node, indy:Location, rocks:Array<Location>, index:Int, pos:Int, tile:Int ) {
		
		final cells = parent.cells.copy();
		final srcTile = cells[index];
		final diff = tileRotations[srcTile].indexOf( tile );
		final modDiff = (( diff + 1 ) % 4 ) - 1;
		cells[index] = tile;
		final node:Node = { parent: parent, cells: cells, indy: indy, rocks:rocks, index: index, tile: tile, diff: modDiff };
		
		return node;
	}

	public function getNextAction( cells:Array<Int>, path:Path ) {
		// trace( "\n" + path.map( node -> '${node.index} tile ${node.tile} diff ${node.diff}').join( "\n" ));
		var action = "";
		for( node in path ) {
			final index = node.index;
			final diff = node.diff;
			if( diff < 0 ) {
				turnTileLeft( cells, index  );
				action = xy( index ) + ' LEFT';
				break;
			} else if( diff > 0 ) {
				turnTileRight( cells, index );
				action = xy( index ) + ' RIGHT';
				break;
			} else action = "WAIT";
		}
		return action;
	}
	
	public function turnTileLeft( cells:Array<Int>, index:Int ) {
		final currentTile = cells[index];
		final tiles = tileRotations[currentTile];
		// trace( 'tile $index (${cells[index]}) turn left -> ${tiles[tiles.length - 1]}' );
		cells[index] = tiles[tiles.length - 1]; // last tile of rotations
	}

	public function turnTileRight( cells:Array<Int>, index:Int ) {
		final currentTile = cells[index];
		final tiles = tileRotations[currentTile];
		// printErr( 'tile $index (${tunnel.cells[index]}) turn right -> ${tiles[1]}' );
		cells[index] = tiles[1]; // next tile of rotations
	}


	public inline function getX( id:Int ) return id % width;
	public inline function getY( id:Int ) return int( id / width );
	inline function getIndex( x:Int, y:Int ) return y * width + x;
	inline function getPos( pos:Int ) {
		return switch pos {
			case 0: "TOP";
			case 1: "LEFT";
			case 2: "RIGHT";
			case i: throw 'Error pos $i is not possible';
		}
	}
	inline function xy( index:Int ) return '${getX( index)} ${getY( index)}';

	public function locationToString( location:Location ) {
		return xy( location.index ) + " " + getPos( location.pos );
	}

	public function cellsToString( cells:Array<Int> ) {
		var output = "";
		final height = int( cells.length / width );
		for( y in 0...height ) {
			final line = [];
			for( x in 0...width ) {
				line.push( cells[getIndex(x, y)] );
			}
			output += line.join(" " ) + "\n";
		}
		return output;
	}

	public function cellsToString3x3( cells:Array<Int>, indy:Location, rocks:Array<Location> ) {
		var output = "";
		final height = int( cells.length / width );
		for( y in 0...height ) {
			for( i in 0...3 ) {
				for( x in 0...width ) {
					final index = getIndex(x, y);
					final cell = cells[index];
					final tile = tiles[cell][i];
					
					final isIndyPosition = indy.index == index;
					final isRockPosition = rocks.fold(( rock, isPosition ) -> isPosition || rock.index == index, false );
					
					if( i == 1 && isIndyPosition) output += tile.charAt( 0 ) + "@" + tile.charAt( 2 );
					else if( i == 1 && isRockPosition ) output += tile.charAt( 0 ) + "O" + tile.charAt( 2 );
					else output += tile;
				}
				output += "\n";
			}
		}
		return output;
	}

	public function cellsToStringUtf8( cells:Array<Int> ) {
		var output = "";
		final height = int( cells.length / width );
		for( y in 0...height ) {
			for( x in 0...width ) {
				final cell = cells[getIndex(x, y)];
				output += tilesUtf8[cell];
			}
			output += "\n";
		}
		return output;
	}

}