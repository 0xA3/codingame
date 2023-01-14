package ai;

import data.TCell;
import search.PathNode;
import xa3.MathUtils.abs;

class Maze {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<TCell>;
	
	public var transporterIndex = -1;
	public var controlRoomIndex = -1;

	public var hasUnknown = false;

	public function new( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
		cells = [for( _ in 0...height * width ) Unknown];
	}

	public function update( lines:Array<String> ) {
		hasUnknown = false;
		for( y in 0...lines.length ) {
			final columns = lines[y].split( '' );
			for( x in 0...columns.length ) {
				final c = columns[x];
				final index = getCellIndex( x, y );
				if( transporterIndex == -1 && c == "T" ) transporterIndex = index;
				else if( controlRoomIndex == -1 && c == "C" ) controlRoomIndex = index;
				
				final inputCell = parseInput( c );
				if( inputCell != cells[index] ) setCell( index, inputCell );
				if( inputCell == Unknown ) hasUnknown = true;
			}
		}
	}

	function parseInput( s:String ) {
		return switch s {
			case 'T': Transporter;
			case 'C': ControlRoom;
			case "#": Wall;
			case "?": Unknown;
			default: Space;
		}
	}

	public function getPathNodes( goal = -1 ) {
		final pathNodes = [];
		for( index in 0...cells.length ) pathNodes[index] = createPathNode( index, goal );
		return pathNodes;
	}

	function createPathNode( index:Int, goal:Int ) {
		final cell = getCell( index );
		if( cell == Wall ) return PathNode.noPathNode;
		if( cell == Unknown ) return new PathNode( index, cell, [], PathNode.MAX_INTEGER );
		
		final neighbors = getNeighbors( index );
		
		final validNeighbors = neighbors.filter( neighborIndex -> {
			final cell = getCell( neighborIndex );
			return cell != Wall;
			// return cell == Space || cell == Unknown;
		});
		
		// trace( 'createPathNode xy $x:$y  index ${getCellIndex( x, y )}  cell $cell  neighbors $neighbors  validNeighbors $validNeighbors' );
		
		final distanceToGoal = goal == -1 ? PathNode.MAX_INTEGER : getDistance( index, goal );
		final pathNode = new PathNode( index, cell, validNeighbors, distanceToGoal );
		return pathNode;
	}

	function getNeighbors( index:Int ) {
		final x = getCellX( index );
		final y = getCellY( index );
		final indices:Array<Int> = [];
		if( y > 0 ) indices.push( getCellIndex( x, y - 1 )); // top
		if( x > 0 ) indices.push( getCellIndex( x - 1, y )); // left
		if( y < height - 1 ) indices.push( getCellIndex( x, y + 1 )); // bottom
		if( x < width - 1 ) indices.push( getCellIndex( x + 1, y )); // right
		
		return indices;
	}

	public function getDirection( startIndex:Int, endIndex:Int ) {
		final delta = endIndex - startIndex;
		return delta == 1 ? "RIGHT"
			: delta == -1 ? "LEFT"
			: delta == -width ? "UP"
			: delta == width ? "DOWN"
			: throw 'Error: endIndex $endIndex (${getCellX( endIndex )}:${getCellY( endIndex )}) is no neighbor of $startIndex (${getCellX( startIndex )}:${getCellY( startIndex )})';
	}

	function getDistance( index1:Int, index2:Int ) {
		if( index1 == index2 ) return 0;
		final x1 = getCellX( index1 );
		final y1 = getCellY( index1 );
		final x2 = getCellX( index2 );
		final y2 = getCellY( index2 );
		final distance = abs( x2 - x1 ) + abs( y2 - y1 );
		// trace( 'distance from ${getCell( index1 )} $index1 ($x1:$y1) to ${getCell( index2 )} $index2 ($x2:$y2)  $distance' );
		return distance;
	}

	public inline function getCell( index:Int ) return cells[index];
	public inline function getCell2d( x:Int, y:Int ) return cells[getCellIndex( x, y )];
	public inline function getCellX( index:Int ) return index % width;
	public inline function getCellY( index:Int ) return Std.int( index / width );
	
	public inline function getCellIndex( x:Int, y:Int ) {
		if( x < 0 ) throw 'Error x $x';
		if( x >= width ) throw 'Error x $x';
		if( y < 0 ) throw 'Error y $y';
		if( y >= height ) throw 'Error y $y';
		
		return y * width + x;
	}

	public function setCell( id:Int, value:TCell ) cells[id] = value;
	public function setCell2d( x:Int, y:Int, value:TCell ) cells[y * width + x] = value;
}

typedef Vec2 = {
	final x:Int;
	final y:Int;
}