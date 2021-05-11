package game;

class Board {
	
	public final map:Map<CubeCoord, Cell>;
	public final coords:Array<CubeCoord>;

	public function new( map:Map<CubeCoord, Cell> ) {
		this.map = map;
		final indexedCoords = [for( coord => cell in map ) { index: cell.index, coord: coord }];
		indexedCoords.sort(( a, b ) -> a.index - b.index );
		coords = indexedCoords.map( indexedCoord -> indexedCoord.coord );
	}

	public function copy( ) {
		final mapCopy = [for( coord => cell in map ) coord => cell];
		return new Board( mapCopy );
	}
}