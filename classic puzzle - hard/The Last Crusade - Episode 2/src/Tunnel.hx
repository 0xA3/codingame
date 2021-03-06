import BreadthFirstSearch;
import CodinGame.printErr;
import Std.int;
import Std.parseInt;
import data.Location;
import data.Node;
import data.Path;
import data.Rotation;
import data.Tiles;
import data.TilesUtf8;
import data.Transformations;
import haxe.ds.GenericStack;

using Lambda;

class Tunnel {
	
	public static final noLocation:Location = { index: -1, pos: -1 };
	public static final noRotation:Rotation = { index: 0, value: 0 };
	public static final rotationSteps = [0, 1, -1, 2];

	public final locked:Array<Bool>;
	public final width:Int;
	public final totalCells:Int;
	
	public function new( locked:Array<Bool>, width:Int, height:Int ) {
		this.locked = locked;
		this.width = width;
		totalCells = width * height;
	}

	public function incrementLocation( index:Int, pos:Int, tile:Int ) {
		final delta = tileMovements[tile][pos];
		// trace( 'index $index pos $pos tile $tile delta $delta' );
		final x = getX( index );
		if(( x == 0 && delta[0] == -1 )||( x == width - 1 && delta[0] == 1 )) return noLocation;
		
		final nextIndex = index + delta[0] + delta[1] * width;
		if( nextIndex == index ) return noLocation;
		if( nextIndex >= totalCells ) return noLocation;
		
		final nextPos = directions[tile][pos];
		final nextLocation:Location = { index: nextIndex, pos: nextPos };
		
		return nextLocation;
	}

	public function extendPathWithVariations( path:Path, cells:Array<Int> ) {
		final startRotNode:Node = { index: path[0].index, pos: path[0].pos, tile: cells[path[0].index] };
		var frontierNodes = [startRotNode];
		for( i in 1...path.length - 1 ) {
			final tempFrontierNodes = [];
			for( parentNode in frontierNodes ) {
				final index = path[i].index;
				final tile = cells[index];
				final pos = path[i].pos;
	
				final destinationIndex = path[i + 1].index;
				final deltaIndex = destinationIndex - index;
				final dx = deltaIndex > 1 ? 0 : deltaIndex;
				final dy = deltaIndex > 1 ? 1 : 0;

				// final rotationTiles = locked[index] ? [tile] : tileRotations[tile];
				final rotationTiles = tileRotations[tile];
				// trace( rotationTiles );
				for( rotationTile in rotationTiles ) {
					final nextPos = tileMovements[rotationTile][pos];
					// trace( 'pos ${xy( index )} rotationTile $rotationTile' );
					if( nextPos[0] == dx && nextPos[1] == dy) {
						final rotNode:Node = { parent: parentNode, index: index, pos: pos, tile: rotationTile };
						tempFrontierNodes.push( rotNode );
					}
				}
			}
			frontierNodes = tempFrontierNodes;
		}
		final exitNodes = [];
		for( parentNode in frontierNodes ) {
			final lastPathNode = path[path.length - 1];
			final rotNode:Node = { parent: parentNode, index: lastPathNode.index, pos: lastPathNode.pos, tile: cells[lastPathNode.index] };
			exitNodes.push( rotNode );
		}

		final paths = exitNodes.map( node -> backtrackNodes( node ));
		return paths;
	}

	public function validatePath( path:Path, cells:Array<Int> ) {
		var sum = 0;
		for( i in 1...path.length ) {
			final node = path[i];
			final currentTile = cells[node.index];
			final rotations = tileRotations[currentTile];
			final difference = rotations.indexOf( node.tile );
			sum += switch difference {
				case 0: 0;
				case 1: 1;
				case 2: 2;
				case 3: 1;
				default: throw 'Error no rotation possible from $currentTile to ${node.tile}';
			}
			sum -= 1;
			// trace( 'index ${node.index} currentTile $currentTile difference $difference sum $sum' );
			if( sum > 0) return false;
		}
		return true;
	}

	public function getRotations( path:Path, cells:Array<Int> ) {
		final rotationsPath = [];
		for( node in path ) {
			final currentTile = cells[node.index];
			final rotations = tileRotations[currentTile];
			final difference = rotations.indexOf( node.tile );
			// trace( 'node ${node.index} tile ${node.tile} difference $difference' );
				final value = switch difference {
					case 0: 0;
					case 1: 1;
					case 2: 2;
					case 3: -1;
					default: throw 'Error no rotation possible from $currentTile to ${node.tile}';
				}
				final rotation:Rotation = { index: node.index, value: value };
				rotationsPath.push( rotation );
		}
		return rotationsPath;
	}

	// public function convertToSingleRotationPath( path:Path ) {
	// 	return [];
	// }

	public function convertToSingleRotations( rotations:Array<Rotation> ) {
		final compressedRotations = [];
		var i = rotations.length - 1;
		var stack = new GenericStack();
		while( i >= 0 ) {
			final rotation = rotations[i];
			switch rotation.value {
				case 0:
					compressedRotations.push( stack.isEmpty() ? rotation : stack.pop() );
				case 2:
					compressedRotations.push({ index: rotation.index, value: 1 });
					stack.add({ index: rotation.index, value: 1 });
				default:
					compressedRotations.push( rotation );
			}
			i--;
		}
		compressedRotations.reverse();
		return compressedRotations;
	}

	public function getRockPath( location:Location, indy:Location, cells:Array<Int> ) {
		var tempLocation = location;
		final path = [];
		while( tempLocation != noLocation && tempLocation.index != indy.index ) {
			path.push( tempLocation );
			tempLocation = incrementLocation( tempLocation.index, tempLocation.pos, cells[tempLocation.index] );
		}
		return path.slice( 1 );
	}

	public function getRockBlockRotations( rockPath:Array<Location>, cells:Array<Int> ) {
		final blockRotations = rockPath.map( location -> getBlockRotation( location, cells[location.index] ));
		return blockRotations;
	}

	function getBlockRotation( location:Location, tile:Int ):Rotation {
		// trace( 'index ${location.index} tile $tile locked ${locked[location.index]}' );
		if( locked[location.index] || tile < 2 || incrementLocation( location.index, location.pos, tile ) == noLocation ) return { index: location.index, value: 0 };

		final rotationTiles = tileRotations[tile];
		final tileRight = rotationTiles[1];
		// trace( 'tileRight $tileRight incrementLocation ${incrementLocation( location.index, location.pos, tileRight )  == noLocation}' );
		if( incrementLocation( location.index, location.pos, tileRight ) == noLocation ) return { index: location.index, value: 1 };

		final tileLeft = rotationTiles[rotationTiles.length - 1];
		if( incrementLocation( location.index, location.pos, tileLeft ) == noLocation ) return { index: location.index, value: -1 };

		return { index: location.index, value: 0 };
	}

	function removeCollidedRocks( rocks:Array<Location> ) {
		rocks.sort(( a, b ) -> b.index - a.index );
		var i = rocks.length - 1;
		while( i > 0 ) {
			final startIndex = rocks[i].index;
			i--;
			if( rocks[i].index == startIndex ) {
				rocks.remove( rocks[i + 1] );
				while( rocks.length > 0 && rocks[i].index == startIndex ) {
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

	public function getChildNodes( currentNode:Node, cells:Array<Int> ) {
		
		final index = currentNode.index;
		if( index == -1 || index >= cells.length ) return [];
		final pos = currentNode.pos;
		final tile = cells[index];
		final childNodes = [];
		// trace( 'currentNode index $index pos $pos tile $tile' );
		if( locked[index] ) {
			final location = incrementLocation( index, pos, cells[index] );
			if( location.index != -1 ) {
				final node:Node = { parent: currentNode, index: location.index, pos: location.pos };
				childNodes.push( node );
			}
		} else {
			final toDirections = movements[tile][pos];
			// printErr( 'pos ${xy( index )} pos $pos tile $tile direction $toDirections' );
			for( direction in toDirections ) {
				switch direction {
					case Below:
						final node:Node = { parent: currentNode, index: index + width, pos: 0 };
						childNodes.push( node );
					case Left:
						if( getX( index ) > 0 ) {
							final node:Node = { parent: currentNode, index: index - 1, pos: 2 };
							childNodes.push( node );
						}
					case Right:
						if( getX( index ) < width - 1 ) {
							final node:Node = { parent: currentNode, index: index + 1, pos: 1 };
							childNodes.push( node );
						}
				}
			}
		}
		return childNodes;
	}

	public function getNextAction( rotation:Rotation, cells:Array<Int> ) {
		// trace( "\n" + path.map( node -> '${node.index} tile ${node.tile} diff ${node.diff}').join( "\n" ));
		
		switch rotation.value {
			case 0: return "WAIT";
			case -1:
				turnTileLeft( cells, rotation.index );
				return '${xy( rotation.index )} LEFT';
			case 1:
				turnTileRight( cells, rotation.index );
				return '${xy( rotation.index )} RIGHT';
			
			default: throw 'Error: illegal rotation value ${rotation.value}';
		}
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
	inline function xy( index:Int ) return '${getX( index )} ${getY( index )}';

	public function locationToString( location:Location ) return xy( location.index ) + " " + getPos( location.pos );

	public function getIndexOfAction( action:String ) {
		final parts = action.split(" ");
		final x = parseInt( parts[0] );
		final y = parseInt( parts[1] );
		final index = y * width + x;
		return index;
	}

	public function cellsToString( cells:Array<Int> ) {
		final cellsWithLocked = combineWithLocked( cells );
		var lines = [];
		final height = int( cellsWithLocked.length / width );
		for( y in 0...height ) {
			final line = [];
			for( x in 0...width ) {
				line.push( cellsWithLocked[getIndex(x, y)] );
			}
			lines.push( line.join(" "));
		}
		return lines.join( "\n" );
	}
	
	function combineWithLocked( cells:Array<Int> ) {
		return cells.mapi(( i, cell ) -> locked[i] ? -cell : cell );
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