import Main.Location;
import Std.int;
import Tiles;

typedef State = {
	final cells:Array<Int>;
}

class Tunnel {
	
	public static var tileMovements:Array<Array<Array<Int>>> = [
		[[0, 0], [0, 0], [0, 0]], // Type  0 - TOP not possible, LEFT not possible, RIGHT not possible
		[[0, 1], [0, 1], [0, 1]], // Type  1 - TOP go down 0:1, LEFT go down 0:1, RIGHT go down 0:1
		[[0, 0], [1, 0], [-1, 0]], // Type  2 - TOP not possible, LEFT go right 1:0, RIGHT go left -1:0
		[[0, 1], [0, 0], [0, 0]], // Type  3 - ...
		[[-1, 0], [0, 0], [0, 1]], // Type  4
		[[1, 0], [0, 1], [0, 0]], // Type  5
		[[0, 0], [1, 0], [-1, 0]], // Type  6
		[[0, 1], [0, 0], [0, 1]], // Type  7
		[[0, 0], [0, 1], [0, 1]], // Type  8
		[[0, 1], [0, 1], [0, 0]], // Type  9
		[[-1, 0], [0, 0], [0, 0]], // Type 10
		[[1, 0], [0, 0], [0, 0]], // Type 11
		[[0, 0], [0, 0], [0, 1]], // Type 12
		[[0, 0], [0, 1], [0, 0]], // Type 13
	];
	
	public static var tileRotations = [
		[0],				// Type 0
		[1],				// Type 1
		[2, 3],				// Type 2
		[3, 2],				// Type 3
		[4, 5],				// Type 4
		[5, 4],				// Type 5
		[6, 7, 8, 9],		// Type 6
		[7, 8, 9, 6],		// Type 7
		[8, 9, 6, 7],		// Type 8
		[9, 6, 7, 8],		// Type 9
		[10, 11, 12, 13],	// Type 10
		[11, 12, 13, 10],	// Type 11
		[12, 13, 10, 11],	// Type 12
		[13, 10, 11, 12],	// Type 13
		
	];

	final cells:Array<Int>;
	final locked:Array<Bool>;
	final width:Int;
	final exit:Int;

	public function new( cells:Array<Int>, width:Int, locked:Array<Bool>, exit:Int ) {
		this.cells = cells;
		this.locked = locked;
		this.width = width;
		this.exit = exit;
	}

	public function getAction( indy:Location, rocks:Array<Location> ) {
		
		final nextCells = getNextCells( indy, rocks );
		return "";
	}

	public function toString() {
		var output = "";
		final height = int( cells.length / width );
		for( y in 0...height ) {
			for( i in 0...3 ) {
				for( x in 0...width ) {
					output += tiles[getIndex(x, y)][i];
					// trace( cell + "'" + tiles[cell][i] + "'" );
				}
				output += "\n";
			}
		}
		return output;
	}

	inline function getIndex( x:Int, y:Int ) return y * width + x;
	inline function getX( id:Int ) return id % width;
	inline function getY( id:Int ) return int( id / width );

	function getNextCells( indy:Location, rocks:Array<Location> ) {
		
		var nextCells = [];
		var x = indy.x;
		var y = indy.y;
		while( true ) {
			final id = getIndex( x, y );
			final tile = cells[id];
			final delta = tileMovements[tile][indy.pos];
			if(( x == 0 && delta[0] == -1 )||( x == width - 1 && delta[0] == 1 )) break;
			
			final nextId = getIndex( x + delta[0], y + delta[1] );
			if( nextId >= cells.length ) break;
			if( nextId == id ) break;
			
			nextCells.push( nextId );
			
			if( nextId == exit ) break;
			
			x += delta[0];
			y += delta[1];
		}
		
		return nextCells;
	}

	function getInitialStates( location:Location, nextCells:Array<Int> ) {
		
		final states:Array<State> = [];
		var prevousX = location.x;
		var prevousY = location.y;
		var prevousPos = location.pos;
		for( c1 in 0...nextCells.length ) {
			// final c1Rotations = locked[c1] ? [cells[c1]] : tileRotations[cells[c1]];
			// final validRotations = c1Rotations.map( tile -> {
				// final delta = tileMovements[tile][indy.pos];
				// tileMovements[tile] )
			
			
			
			// for( c2 in c1...nextCells.length ) {
			// 	final c2Rotations = tileRotations[cells[c2]];
			// 	for( r1 in c1Rotations ) {
			// 		for( r2 in c2Rotations ) {
			// 			final state:State = { cells: cells.copy() };
			// 			state.cells[c1] = r1;
			// 			state.cells[c2] = r2;
			// 			states.push( state );
			// 		}
			// 	}
			// }
		}
		return states;
	}
}