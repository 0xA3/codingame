using Lambda;

class CoastLength {

	public static function get( island:Array<Int>, grid:Array<String>, width:Int, visited:Array<Bool> ) {
		final waterNeighbors = island.flatMap( pos -> getWaterNeighbors( pos, grid, width, visited ));
		
		return waterNeighbors.length;
	}

	static function getWaterNeighbors( pos:Int, grid:Array<String>, width:Int, visited:Array<Bool> ) {
		final x = pos % width;

		final neighborPositions = [];
		if( x > 0 ) neighborPositions.push( pos - 1 );
		if( x < width - 1 ) neighborPositions.push( pos + 1 );
		if( pos >= width ) neighborPositions.push( pos - width );
		if( pos + width < grid.length ) neighborPositions.push( pos + width );
		final validPositions = [];
		for( neighbor in neighborPositions ) {
			if( grid[neighbor] == "~" && !visited[neighbor] ) {
				validPositions.push( neighbor );
				visited[neighbor] = true;
			}
		}
		
		return validPositions;
	}
}