class Setter {
	
	final gridSize:Int;
	final grid:Array<Array<Int>>;
	final visited:Array<Array<Bool>> = [];
	
	public function new( gridSize:Int, grid:Array<Array<Int>> ) {
		this.gridSize = gridSize;
		this.grid = grid;
	}

	public function getSets() {
		
		initVisited();
		
		final sets = [];
		for( y in 0...gridSize ) {
			for( x in 0...gridSize ) {
				final color = grid[y][x];
				if( !visited[y][x] && color != -1 ) {
					final set = [];
					
					addTile( set, x, y );
					final set = [{ x: x, y: y }];
					// printErr( 'position $x:$y $color' );
					addSameColorNeighbors( set, x, y, color );
					sets.push( set );
				}
			}
		}
		return sets;
	}
	
	function initVisited() {
		for( y in 0...grid.length ) {
			visited[y] = [];
			for( x in 0...grid[y].length ) {
				visited[y][x] = false;
			}
		}
	}

	function addSameColorNeighbors( set:Array<Tile>, x:Int, y:Int, color:Int ) {
		final startPosition = set.length;
		if( x > 0 ) {
			final neighborX = x - 1;
			final neighborY = y;
			if( check( neighborX, neighborY, color )) addTile( set, neighborX, neighborY );
		}
		if( x < gridSize - 1 ) {
			final neighborX = x + 1;
			final neighborY = y;
			if( check( neighborX, neighborY, color )) addTile( set, neighborX, neighborY );
		}
		if( y > 0 ) {
			final neighborX = x;
			final neighborY = y - 1;
			if( check( neighborX, neighborY, color )) addTile( set, neighborX, neighborY );
		}
		if( y < gridSize - 1 ) {
			final neighborX = x;
			final neighborY = y + 1;
			if( check( neighborX, neighborY, color )) addTile( set, neighborX, neighborY );
		}
		final endPosition = set.length;
		for( i in startPosition...endPosition ) {
			addSameColorNeighbors( set, set[i].x, set[i].y, color );
		}

	}

	function check( x:Int, y:Int, color:Int ) {
		// printErr( 'check $x:$y $color - ${!visited[y][x] && grid[y][x] == color}' );
		return !visited[y][x] && grid[y][x] == color;
	}

	function addTile( set:Array<Tile>, x:Int, y:Int ) {
		visited[y][x] = true;
		set.push({ x: x, y: y });
		// printErr( 'add $x:$y' );
	}

}

typedef Tile = {
	final x:Int;
	final y:Int;
}