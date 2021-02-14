import Location;
import Std.int;
import Tiles;
import Transformations;

class State {
	
	public static final noLocation:Location = { index: -1, pos: -1 };

	public final parent:State;
	public final location:Location;
	public final rocks:Array<Location>;
	public final cells:Array<Int>;
	public final locked:Array<Bool>;
	public final width:Int;
	
	public function new( location:Location, rocks:Array<Location>, cells:Array<Int>, locked:Array<Bool>, width:Int, ?parent:State ) {
		this.location = location;
		this.rocks = rocks;
		this.cells = cells;
		this.locked = locked;
		this.width = width;
		this.parent = parent;
	}

	public function getNextCellLocation() {
		
		final index = location.index;
		final tile = cells[index];
		final delta = tileMovements[tile][location.pos];
		
		final x = getX( index );
		if(( x == 0 && delta[0] == -1 )||( x == width - 1 && delta[0] == 1 )) return noLocation;
		
		final nextIndex = index + delta[0] + delta[1] * width;
		
		if( nextIndex == index ) return noLocation;
		if( nextIndex >= cells.length ) return noLocation;
		
		final nextPos = directions[tile][location.pos];
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
	
	public function getChildStates( nextLocation:Location, rotationTiles:Array<Int> ) {
	
		final childStates = [];
		for( tile in rotationTiles ) {
			final nextCells = cells.copy();
			nextCells[nextLocation.index] = tile;
			final nextState = new State( nextLocation, rocks, nextCells, locked, width, this );
			childStates.push( nextState );
		}

		return childStates;
	}

	inline function getX( id:Int ) return id % width;
	inline function getIndex( x:Int, y:Int ) return y * width + x;

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