package ai;

import data.TCell;
import search.PathNode;

class Maze {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<TCell>;
	public final pathNodes:Map<Int, PathNode> = [];
	
	public var transporterIndex = -1;
	public var controlRoomIndex = -1;

	public function new( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
		cells = [for( _ in 0...height * width ) Unknown];
	}

	public function update( lines:Array<String> ) {
		for( y in 0...lines.length ) {
			final columns = lines[y].split( '' );
			for( x in 0...columns.length ) {
				final c = columns[x];
				final index = getCellIndex( x, y );
				if( transporterIndex == -1 && c == "T" ) transporterIndex = index;
				else if( controlRoomIndex == -1 && c == "C" ) controlRoomIndex = index;
				
				final inputCell = parseInput( c );
				if( inputCell != cells[index] ) setCell( index, inputCell );
			}
		}
		for( index in 0...cells.length ) createPathNode( index );
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

	function createPathNode( index:Int ) {
		final cell = getCell( index );
		if( cell == Wall ) return;
		
		final x = getCellX( index );
		final y = getCellY( index );
		final neighbors = getNeighbors( index );
		
		final validNeighbors = neighbors.filter( neighborIndex -> {
			final cell = getCell( neighborIndex );
			return cell != Wall;
			// return cell == Space || cell == Unknown;
		});
		
		// trace( 'createPathNode xy $x:$y  index ${getCellIndex( x, y )}  cell $cell  neighbors $neighbors  validNeighbors $validNeighbors' );
		
		final id = getCellIndex( x, y );
		final pathNode = new PathNode( id, getCell( index ), validNeighbors );
		pathNodes.set( index, pathNode );
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
			: throw 'Error: endIndex $endIndex not directly reachable form startIndex $startIndex';
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