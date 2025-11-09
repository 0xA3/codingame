class Grid {
	
	public final index:Int;
	final content:Array<Array<String>>;
	public var infected(default, null) = 0;

	public function new( index:Int, content:Array<Array<String>>, infected = 0 ) {
		this.index = index;
		this.content = content;
		this.infected = infected;
	}

	public function getNextGrid() {
		final nextContent = this.content.copy();
		var newInfected = 0;
		for( y in 0...content.length ) {
			for( x in 0...content[y].length ) {
				if( content[y][x] == "C" ) {
					final neighborPositions = getNeighborPositions( x, y );

					for( neighbor in neighborPositions ) {
						final nx = neighbor[0];
						final ny = neighbor[1];
						if( content[neighbor[1]][neighbor[0]] == "." ) {
							nextContent[ny][nx] = "C";
							newInfected++;
						}
					}
				}
			}
		}

		return new Grid( index, nextContent, infected + newInfected );
	}

	function getNeighborPositions( x:Int, y:Int ) {
		final neighborPositions = [];
		if( x > 0 && y > 0 ) neighborPositions.push([x - 1, y - 1] );
		if( x > 0 && y < content.length - 1 ) neighborPositions.push([x - 1, y + 1] );
		if( x < content[y].length - 1 && y > 0 ) neighborPositions.push([x + 1, y - 1] );
		if( x < content[y].length - 1 && y < content.length - 1 ) neighborPositions.push( [x + 1, y + 1] );

		return neighborPositions;
	}

	public function initNumberOfInfected() {
		var n = 0;
		for( y in 0...content.length ) {
			for( x in 0...content[y].length ) {
				if( content[y][x] == "C" ) {
					n++;
				}
			}
		}

		infected = n;
	}

	public function toOutput() {
		return '$index\n' + content.map( row -> row.join( "" )).join( "\n" );
	}
}