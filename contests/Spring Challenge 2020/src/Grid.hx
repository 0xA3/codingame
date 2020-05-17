import astar.Graph;

class Grid {
	
	public final width:Int;
	public final widthHalf:Int;
	public final height:Int;
	final floors:Array<Bool>;
	public final cells:Array<Cell>;
	final graph:Graph;

	public final superPellets:Array<Int> = [];

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

	public function getCellIndicesAroundPosition( x:Int, y:Int, types:Array<Cell>, max:Int ) {
		
		final indices:Array<Int> = [];
		for( r in 1...widthHalf + 1 ) {
			final cTop = y - r;
			final cLeft = x - r;
			final cBottom = y + r;
			final cRight = x + r;
			if( indices.length > max ) break;

			final rTop = Std.int( Math.max( 0, cTop ));
			final rBottom = Std.int( Math.min( height - 1, cBottom ));

			final rLeft = ( width + cLeft ) % width;
			for( yp in rTop...rBottom ) {
				final index = getCellIndex( rLeft, yp );
				if( types.contains( cells[index] )) indices.push( index );
			}
			
			if( rBottom == cBottom ) for( xp in cLeft...cRight ) {
				final rp = ( width + xp ) % width;
				final index = getCellIndex( rp, rBottom );
				if( types.contains( cells[index] )) indices.push( index );
			}

			final rRight = cRight % width;
			for( yp in -rBottom...-rTop ) {
				final index = getCellIndex( rRight, -yp );
				if( types.contains( cells[index] )) indices.push( index );
			}
			
			if( rTop == cTop ) for( xp in -cRight...-cLeft ) {
				final rp = ( width - xp ) % width;
				final index = getCellIndex( rp, rTop );
				if( types.contains( cells[index] )) indices.push( index );
			}
		}
		return indices;
	}

	// public function updateGraph() {
	// 	final worldMap = cells.map( c -> switch c {
	// 		case Wall | Friend | Enemy: 1;
	// 		default: 0;
	// 	});
	// 	graph.setWorld( worldMap );
	// }

	public function getPath( from:Int, to:Int ) {
		final s = '${from}_${to}';
		final startX = getCellX( from );
		final startY = getCellY( from );
		final endX = getCellX( to );
		final endY = getCellY( to );
		final result = graph.solve( startX, startY, endX, endY );
		return result;
	}

	/*
	Possible destinations
		2
	  2 1 2
	2 1 × 1 2
	  2 1 2
		2
	*/
	public function getPossibleDestinations( x:Int, y:Int, speed = false ) {
		final destinations = speed
		? [
			                  [x,y-2],
			        [x-1,y-1],[x,y-1],[x+1,y-1],
			[x-2,y],[x-1,y  ],[x,y  ],[x+1,y  ],[x+2,y],
			        [x-1,y+1],[x,y+1],[x+1,y+1],
			                  [x,y+2]
		] : [
			        [x,y-1],
			[x-1,y],[x,y  ],[x+1,y],
			        [x,y+1]
		];
		
		final destinationIndices = destinations
			.filter( cropXY )
			.map( wrapXY )
			.map( xy -> getCellIndex( xy[0], xy[1] ));
		
		// trace( [for( i in 0...destinationIndices.length ) '[${getCellX( destinationIndices[i] )} ${getCellY( destinationIndices[i] )}]'] );
			// filter out +2 positions when position inbetween is wall
		// 	     0
		// 	  1  2  3
		// 4  5  6  7  8
		// 	  9 10 11
		// 	    12
			  
		if( speed ) {
			if( !floors[destinationIndices[10]] ) destinationIndices.splice( 12, 1 );
			if( !floors[destinationIndices[7]] ) destinationIndices.splice( 8, 1 );
			if( !floors[destinationIndices[5]] ) destinationIndices.splice( 4, 1 );
			if( !floors[destinationIndices[2]] ) destinationIndices.splice( 0, 1 );
		}

		final destinationsWithoutWalls = destinationIndices.filter( index -> floors[index] );
		
		// if( x == 9 && y == 3 ) {
			// for( i in possibleDestinationIndices ) CodinGame.printErr( '${getCellX(i)} ${getCellY(i)}' );
		// }
		return destinationsWithoutWalls;
		
	}

	inline function cropXY( xy:Array<Int> ) {
		// trace( 'y ${xy[1]} >= 0  ${xy[1] < 0}  y ${xy[1]} < $height  ${xy[1] < height}' );
		return xy[1] >= 0 || xy[1] < height;
	}

	inline function wrapXY( xy:Array<Int> ) {
		final x = ( width + xy[0] ) % width;
		return [x, xy[1]];
	}

	public inline function wrapX( x:Int ) {
		return ( width + x ) % width;
	}

	public inline function checkFloor2d( x:Int, y:Int ) {
		if( y < 0 || y >= height ) return false;
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
		// if( x < 0 ) throw 'Error x $x';
		// if( x >= width ) throw 'Error x $x';
		// if( y < 0 ) throw 'Error y $y';
		// if( y >= height ) throw 'Error y $y';
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

	public function sxy( index:Int ) {
		return '[${getCellX( index )}:${getCellY( index )}]';
	}

	public function m2s( m:Map<Int,Float> ) {
		var a:Array<String> = [];
		for( index => priority in m ) {
			a.push( '${sxy( index )}: $priority' );
		}
		return a.join(", ");
	}

}