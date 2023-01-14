import Std.int;

using Lambda;

class Grid {
	
	final size:Int;
	final grid:Array<String>;
	final checked:Array<Bool>;
	final cells:Array<Int>;

	public function new( lines:Array<String>, inputSize:Int ) {
		size = inputSize + 2;
		final inputGrid = lines.map( line -> line.split( "" ));
		final widenedInputGrid = inputGrid.flatMap( line -> ["."].concat( line ).concat( ["."] ));
		grid = [for( i in 0...size ) "."].concat( widenedInputGrid ).concat( [for( i in 0...size ) "."] );
		checked = grid.map( _ -> false );
		cells = grid.map( _ -> -1 );
		
	}

	public function fill() {
		
		var level = 0;
		for( i in 0...cells.length ) {
			if( cells[i] == -1 ) {
				if( isFence( i )) cells[i] = 0;
				else {
					floodFill( i, level + 1 );
				}
			} else {
				if( cells[i] > 0 ) level = cells[i];
			}
		}
		
		// trace( "\n" + cellToString());
	}

	public function countMolehillsInside() {
		
		var count = 0;
		for( i in 0...grid.length ) {
			if( grid[i] == "o" ) {
				if( cells[i] > 0 && cells[i] % 2 == 0 ) count++;
			}
		}
		return count;
	}

	function isFence( index:Int ) {
		return grid[index] == "+" || grid[index] == "-" || grid[index] == "|";
	}

	function floodFill( index:Int, level:Int ) {
		
		final queue = new List<Int>();
		queue.add( index );

		while( !queue.isEmpty() ) {
			final current = queue.pop();

			final x = getX( current );
			final y = getY( current );
			cells[index] = level;

			final adjacent = [
				getIndex( x - 1, y ),
				getIndex( x, y + 1 ),
				getIndex( x + 1, y ),
				getIndex( x, y - 1 )
			];

			for( a in adjacent ) {
				if( isValid( a )) {
					queue.add( a );
					cells[a] = level;
				}
				if( a > 0 && a < grid.length ) checked[a] = true;
			}

		}
	}

	function isValid( index:Int ) {
		return index > 0 && index < grid.length && checked[index] == false && grid[index] != "+" && grid[index] != "-" && grid[index] != "|";
	}

	public function toString() {
		var output = "";
		for( i in 0...grid.length ) {
			output += grid[i];
			if( getX( i ) == size - 1 ) output += "\n";
		}
		return output;
	}

	function cellToString() {
		var output = "";
		for( i in 0...cells.length ) {
			output += switch cells[i] {
				case -1: " ";
				case 0: " "; // fence
				case l: '$l'; // level
			}
			if( getX( i ) == size - 1 ) output += "\n";
		}
		return output;
	}

	inline function getX( index:Int ) {
		return index % size;
	}

	inline function getY( index:Int ) {
		return int( index / size );
	}

	inline function getIndex( x:Int, y:Int ) {
		return y * size + x;
	}

}
