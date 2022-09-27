class BreadthFirstSearch {

	public static function search( grid:Array<String>, width:Int, start:Int, visited:Array<Bool> ) {
		
		final frontier = new List<Int>();
		frontier.add( start );
		
		final island:Array<Int> = [];
		while ( !frontier.isEmpty()) {
			final pos = frontier.pop();
			island.push( pos );
			visited[pos] = true;
			final neighbors = getNeighbors( pos, grid, width, visited );
			for( node in neighbors ) frontier.add( node );
		}

		return island;
	}

	static function getNeighbors( pos:Int, grid:Array<String>, width:Int, visited:Array<Bool> ) {
		final x = pos % width;
		
		final neighborPositions = [];
		if( x > 0 ) neighborPositions.push( pos - 1 );
		if( x < width - 1 ) neighborPositions.push( pos + 1 );
		if( pos >= width ) neighborPositions.push( pos - width );
		if( pos + width < grid.length ) neighborPositions.push( pos + width );
		final validPositions = neighborPositions.filter( v -> grid[v] == "#" && !visited[v] );
		
		return validPositions;	
	}
}
