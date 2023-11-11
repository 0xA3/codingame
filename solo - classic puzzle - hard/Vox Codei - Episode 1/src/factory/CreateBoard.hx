package factory;

class CreateBoard {
	
	public static function create( width:Int, height:Int, rows:Array<String> ) {
		final grid = [for( _ in 0...height ) [for( _ in 0...width ) 0]];
		final inputGrid = rows.map( row -> row.split( "" ));
		
		var numSurveillanceNodes = 0;
		for( y in 0...inputGrid.length ) {
			final row = inputGrid[y];
			for( x in 0...row.length ) {
				final cell = row[x];
				switch cell {
					case "@":
						grid[y][x] = Board.SURVELLANCE_NODE;
						numSurveillanceNodes++;
					case "#": grid[y][x] = Board.PASSIVE_NODE;
					default: // no-op
				}
			}
		}
		
		return new Board( width, height, grid, numSurveillanceNodes );
	}
}