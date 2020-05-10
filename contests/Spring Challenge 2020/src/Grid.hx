import astar.Graph;

class Grid {
	
	public final width:Int;
	public final widthHalf:Int;
	public final height:Int;
	final floors:Array<Bool>;
	public final cells:Array<Cell>;
	final distances:Map<String, Float> = [];

	public final superPellets:Array<Int> = [];

	final graph:Graph;

	public function new( width:Int, height:Int, floors:Array<Bool>, cells:Array<Cell>, graph:Graph ) {
		this.width = width;
		widthHalf = Std.int( width / 2 );
		this.height = height;
		this.floors = floors;
		this.cells = cells;
		this.graph = graph;
	}

	public function getVisibleCellIndices( pacX:Int, pacY:Int ) {
		
		final visibleCellIds:Array<Int> = [];
		// go left
		for( dx in 1...widthHalf + 1 ) {
			final x = ( width + pacX - dx ) % width;
			// trace( "left", x, pacY, checkFloor2d( x, pacY ));
			if( checkFloor2d( x, pacY )) visibleCellIds.push( getCellIndex( x, pacY ));
			else break;
		}
		// go right
		for( dx in 1...widthHalf + 1 ) {
			final x = ( pacX + dx ) % width;
			// trace( "right", x, pacY, checkFloor2d( x, pacY ));
			if( checkFloor2d( x, pacY )) visibleCellIds.push( getCellIndex( x, pacY ));
			else break;
		}
		// go up
		for( dy in 1...height ) {
			final y = pacY - dy;
			// trace( "up", pacX, y, checkFloor2d( pacX, y ));
			if( checkFloor2d( pacX, y )) visibleCellIds.push( getCellIndex( pacX, y ));
			else break;
		}
		// go down
		for( dy in 1...height ) {
			final y = pacY + dy;
			// trace( "down", pacX, y, checkFloor2d( pacX, y ));
			if( checkFloor2d( pacX, y )) visibleCellIds.push( getCellIndex( pacX, y ));
			else break;
		}
		return visibleCellIds;
	}

	public function getDistance( from:Int, to:Int ) {
		final s = '${from}_${to}';
		if( distances.exists( s )) return distances[s];
		final startX = getCellX( from );
		final startY = getCellY( from );
		final endX = getCellX( to );
		final endY = getCellY( to );
		final result = graph.solve( startX, startY, endX, endY );
		if( result.result == Solved ) {
			distances.set( '${from}_${to}', result.cost );
			distances.set( '${to}_${from}', result.cost );
		}
		return result.cost;
	}

	public inline function checkFloor2d( x:Int, y:Int ) {
		return floors[getCellIndex( x, y )];
	}

	public inline function getCell( id:Int ) {
		return cells[id];
	}

	public inline function getCell2d( x:Int, y:Int ) {
		return cells[getCellIndex( x, y )];
	}

	public function setCell( id:Int, value:Cell ) {
		cells[id] = value;
	}

	public function setCell2d( x:Int, y:Int, value:Cell ) {
		cells[y * width + x] = value;
	}

	public inline function getCellIndex( x:Int, y:Int ) {
		return y * width + x;
	}

	public inline function getCellX( id:Int ) {
		return id % width;
	}

	public inline function getCellY( id:Int ) {
		return Std.int( id / width );
	}

	public function toString() {
		return 'width $width, height $height, cells $cells';
	}

}