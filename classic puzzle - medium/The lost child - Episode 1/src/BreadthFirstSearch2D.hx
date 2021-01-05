import Std.int;

using Lambda;

enum Cell {
	Road;
	Wall;
	Start;
	Goal;
}

class BreadthFirstSearch2D {
	
	public static function getPath( cells:Array<Cell>, size:Int ) {
		
		final start = cells.indexOf( Start );
		final visited = [for( i in 0...cells.length ) false];
		final previous = [for( i in 0...cells.length ) -1];
		
		final frontier = new List<Int>();
		
		frontier.add( start );
		visited[start] = true;

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// trace( 'current $current isGoal ${cells[current] == Goal}' );

			if( cells[current] == Goal ) return getDistance( current, previous );

			final x = current % size;
			final y = int( current / size );
			
			// trace( 'current $current $x:$y' );
			// displayVisited( visited, size );
			// displayPrevious( previous, size );

			if( x > 0 ) {
				final left = current - 1;
				if( checkCell( left, visited, cells )) addCell( left, current, frontier, visited, previous );
			}
			if( y < size - 1 ) {
				final bottom = current + size;
				if( checkCell( bottom, visited, cells )) addCell( bottom, current, frontier, visited, previous );
			}
			if( x < size - 1 ) {
				final right = current + 1;
				if( checkCell( right, visited, cells )) addCell( right, current, frontier, visited, previous );
			}
			if( y > 0 ) {
				final top = current - size;
				if( checkCell( top, visited, cells )) addCell( top, current, frontier, visited, previous );
			}
			
		}
		return -1;
	}

	static inline function checkCell( id:Int, visited:Array<Bool>, cells:Array<Cell> ) {
		return !visited[id] && cells[id] != Wall;
	}

	static inline function addCell( id:Int, current:Int, frontier:List<Int>, visited:Array<Bool>, previous:Array<Int> )  {
		frontier.add( id );
		visited[id] = true;
		previous[id] = current;
	}

	static function getDistance( goal:Int, previous:Array<Int> ) {
		var current = goal;
		var distance = 0;
		// trace( 'goal $current  distance $distance' );
		do {
			distance++;
			current = previous[current];
			// trace( 'prev $current  distance $distance' );
		} while( previous[current] != -1 );
		return distance;
	}

	static function displayVisited( visited:Array<Bool>, size:Int ) {
		var line = "";
		for( i in 0...visited.length ) {
			final x = i%size;
			line += visited[i] ? 1 : 0;
			if( x == size - 1 ) {
				trace( line );
				line = "";
			}

		}
	}
	static function displayPrevious( previous:Array<Int>, size:Int ) {
		var line = "";
		for( i in 0...previous.length ) {
			final x = i%size;
			line += previous[i] + "  ";
			if( x == size - 1 ) {
				trace( line );
				line = "";
			}

		}
	}
}