import astar.Graph;

class Grid {
	
	public final width:Int;
	public final widthHalf:Int;
	public final height:Int;
	final floors:Array<Bool>;
	public final cells:Array<Cell>;

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

	public function getPath( from:Int, to:Int ) {
		final s = '${from}_${to}';
		final startX = getCellX( from );
		final startY = getCellY( from );
		final endX = getCellX( to );
		final endY = getCellY( to );
		final result = graph.solve( startX, startY, endX, endY );
		return result;
	}

/*	public function getPossibleDestinations( x:Int, y:Int, speed:Bool ) {
		
		final directions:Array<Int> = [getCellIndex( x, y )];
		final rto = speed ? 2 : 1;
		for( r in 1...rto + 1 ) {
			final cTop = y - r;
			final cLeft = x - r;
			final cBottom = y + r;
			final cRight = x + r;

			final rTop = Std.int( Math.max( 0, cTop ));
			final rBottom = Std.int( Math.min( height - 1, cBottom ));

			// if( x == 31 && y == 4 ) CodinGame.printErr( 'top $cTop left $cLeft bottom $cBottom right $cRight' );

			final rLeft = ( width + cLeft ) % width;
			for( yp in rTop...rBottom ) directions.push( getCellIndex( rLeft, yp ));
			
			if( rBottom == cBottom ) for( xp in cLeft...cRight ) {
				final rp = ( width + xp ) % width;
				directions.push( getCellIndex( rp, rBottom ));
			}
			
			final rRight = cRight % width;
			for( yp in -rBottom...-rTop ) directions.push( getCellIndex( rRight, -yp ));
			
			if( rTop == cTop ) for( xp in -cRight...-cLeft ) {
				final rp = ( width - xp ) % width;
				// if( x == 31 && y == 4 ) CodinGame.printErr( 'xp $xp -cRight ${-cRight} -cLeft ${-cLeft} rp $rp' );
				directions.push( getCellIndex( rp, rTop ));
			}

		}
		directions.sort((a, b) -> a - b );
		final possibleDirections = directions.filter( index -> floors[index] );
		return possibleDirections;
	}
*/

/*
Possible destinations
    2
  2 1 2
2 1 X 1 2
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
		final possibleDestinationIndices = destinations
			.filter( cropY )
			.map( wrapX )
			.map( xy -> getCellIndex( xy[0], xy[1] ))
			.filter( index -> floors[index] );
		
		// if( x == 9 && y == 3 ) {
			// for( i in possibleDestinationIndices ) CodinGame.printErr( '${getCellX(i)} ${getCellY(i)}' );
		// }
		return possibleDestinationIndices;
		
	}

	inline function cropY( xy:Array<Int> ) {
		if( xy[1] < 0 || xy[1] >= height ) return false;
		return true;
	}

	inline function wrapX( xy:Array<Int> ) {
		xy[0] = ( width + xy[0] ) % width;
		return xy;
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
		return '${getCellX( index )}:${getCellY( index )}';
	}

}