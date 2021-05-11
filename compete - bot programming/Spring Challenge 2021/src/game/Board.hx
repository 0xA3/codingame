package game;

class Board {
	
	public final cubeMap:Map<CubeCoord, Cell>;
	public final map:Map<String, Cell>;
	public final coords:Array<CubeCoord>;

	public function new( map:Map<CubeCoord, Cell> ) {
		this.cubeMap = map;
		this.map = [for( coord => cell in map ) coord.s => cell];
		final indexedCoords = [for( coord => cell in map ) { index: cell.index, coord: coord }];
		indexedCoords.sort(( a, b ) -> a.index - b.index );
		coords = indexedCoords.map( indexedCoord -> indexedCoord.coord );
	}

	public function copy( ) {
		final mapCopy = [for( coord => cell in cubeMap ) coord => cell];
		return new Board( mapCopy );
	}
}