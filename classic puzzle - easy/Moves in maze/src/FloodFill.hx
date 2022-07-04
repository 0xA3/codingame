class FloodFill {
	
	final inputGrid:Array<Array<String>>;
	final startPosition:Position;
	final w:Int;
	final h:Int;

	final positions = new List<Position>();

	public function new( inputGrid:Array<Array<String>>, w:Int, h:Int, startPosition:Position ) {
		this.inputGrid = inputGrid;
		this.w = w;
		this.h = h;
		this.startPosition = startPosition;
	}

	public function fill( distanceGrid:Array<Array<Int>> ) {
		positions.add( startPosition );
		
		while( !positions.isEmpty() ) {
			final position = positions.pop();
			final x = position.x;
			final y = position.y;
			final distance = position.distance;

			if( inputGrid[y][x] != "#" && distanceGrid[y][x] == -1 ) {
				distanceGrid[y][x] = distance;

				final nextDistance = distance + 1;
				positions.add({ x: ( x + 1 ) % w, y : y, distance: nextDistance });
				positions.add({ x: ( w + x - 1 ) % w, y : y, distance: nextDistance });
				positions.add({ x: x, y : ( y + 1 ) % h, distance: nextDistance });
				positions.add({ x: x, y : ( h + y - 1 ) % h, distance: nextDistance });
			}
		}
	}
}
