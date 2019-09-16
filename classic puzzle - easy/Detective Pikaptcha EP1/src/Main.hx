using Lambda;

class Main {
	
	static final ajacentDeltas = [{ x:0, y:-1 }, { x:-1, y:0 }, { x:0, y:1 }, { x:1, y:0 }];

	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final width = Std.parseInt( inputs[0] );
		final height = Std.parseInt( inputs[1] );
		final maze = [for( i in 0...height) CodinGame.readline().split("")];

		CodinGame.printErr( 'width $width  height $height' );
		for( line in maze ) CodinGame.printErr( line );

		final output = compute( maze, width, height );
		for( line in output ) CodinGame.print( line );
	}

	static function compute( maze:Array<Array<String>>, width:Int, height:Int ):Array<String> {

		final output = maze.mapi(( y, row ) -> {
			return row.mapi(( x, cell ) -> {
				
				if( cell == "#" ) return "#";

				final adjacentCells = getAdjacentCells( x, y, maze, width );
				final passableCellsSum = adjacentCells.fold(( cell, sum ) -> cell == "0" ? sum + 1 : sum, 0 );
				return Std.string( passableCellsSum );
			});
		});

		return output.map( a -> a.join(""));
	}

	static function getAdjacentCells( x, y, maze:Array<Array<String>>, width:Int ):Array<String> {
		
		final adjacentPositions = ajacentDeltas.map( adjacentDelta -> { x: x + adjacentDelta.x, y: y + adjacentDelta.y });
		return adjacentPositions.map( adjacentPosition -> getCell( adjacentPosition.x, adjacentPosition.y, maze, width ));
	}

	static function getCell( x:Int, y:Int, maze:Array<Array<String>>, width:Int ):String {
		
		if(y < 0 || y >= maze.length ) return "#";
		if(x < 0 || x >= width ) return "#";

		return maze[y][x];
	}

}

typedef Position = {
	final x:Int;
	final y:Int;
}