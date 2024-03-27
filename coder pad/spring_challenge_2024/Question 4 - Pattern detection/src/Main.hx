import Std.int;

var circleCoordinates:Array<Array<Array<Int>>> = [];

@:native("findLargestCircle")
@:keep function findLargestCircle( nRows:Int, nCols:Int, image:Array<String> ) {
	final maxRadius = min( int( nRows / 2 ), int( nCols / 2 ));
	// trace( maxRadius );
	
	circleCoordinates = createCircleCoordinates( maxRadius );
	// for( r in 0...circleCoordinates.length ) trace( '$r: ${circleCoordinates[r]}' );

	// split lines
	final grid = image.map( line -> line.split( "" ));
	
	for( i in -maxRadius...0 ) {
		final radius = -i;
		final centerStartX = radius;
		final centerEndX = nCols - radius;
		final centerStartY = radius;
		final centerEndY = nRows - radius;
		final coordinatesOfRadius = circleCoordinates[radius];

		// trace( 'radius $radius  centerStartX $centerStartX centerEndX $centerEndX centerStartY $centerStartY centerEndY $centerEndY' );

		for( centerY in centerStartY...centerEndY ) {
			for( centerX in centerStartX...centerEndX ) {
				final firstCoordinate = coordinatesOfRadius[0];
				final firstX = centerX + firstCoordinate[0];
				final firstY = centerY + firstCoordinate[1];
				final firstChar = grid[firstY][firstX];

				// trace( 'firstCoordinate $firstCoordinate  firstX $firstX firstY $firstY firstChar $firstChar' );

				var isCircle = true;
				for( coord in 1...coordinatesOfRadius.length ) {
					final x = centerX + coordinatesOfRadius[coord][0];
					final y = centerY + coordinatesOfRadius[coord][1];
					final char = grid[y][x];
					// trace( 'x $x  y $y  char $char' );
					if( char != firstChar ) {
						isCircle = false;
						break;
					}
				}

				if( isCircle ) {
					return [centerY, centerX, radius];
				}
			}
		}
	}
	
	throw 'Error: no circle found.';
}

function min( a:Int, b:Int ) return a < b ? a : b;
/*
function findCircle( y:Int, left:Int, right:Int, char:String ) {
	// get possible radiuses
	// filter in radiuses that are bigger than current biggest circle
	// check chars on opposite side
	// if they are the same check on left side
	// if they are the same check on right side
	// if they are again the same check full circle
	// if it is a circle add center and radius to found circles
	
	final width = right - left + 1;
	// trace( 'findCircle $y $char  from $left to $right  width $width' );
	if( radWidths.exists( width )) {
		// trace( 'y $y char $char  from $left to $right  width $width  rads ${radWidths[width]}' );
		final possibleRads = radWidths[width];
		for( r in possibleRads ) {
			if( r < largestCircle[2] ) continue;

			var isCircle = true;
			final halfWidth = int( width / 2 );
			final centerX = left + halfWidth;
			final centerY = y + r;
			// trace( 'test char $char radius $r  center $centerX:$centerY' );
			
			// bottom of circle
			final yBottom = centerY + r;
			if( yBottom >= grid.length ) continue;
			// trace( 'bottom row ${grid[yBottom].slice( left, right + 1 ).join( "" )}' );
			
			for( x in left...right + 1 ) {
				if( grid[yBottom][x] != char ) isCircle = false;
			}
			if( !isCircle ) continue;
			// trace( 'bottom found' );
			
			// left of circle
			final xLeft = centerX - r;
			final top = centerY - halfWidth;
			final bottom = centerY + halfWidth;
			// trace( 'left column ${grid.slice( top, bottom + 1 ).map( row -> row[xLeft] ).join( "" )}' );

			for( y in top...bottom + 1 ) {
				if( grid[y][xLeft] != char ) isCircle = false;
			}
			if( !isCircle ) continue;
			// trace( 'left found' );

			// right of circle
			final xRight = centerX + r;
			// trace( 'right column ${grid.slice( top, bottom + 1 ).map( row -> row[xRight] ).join( "" )}' );
			for( y in top...bottom + 1 ) {
				if( grid[y][xRight] != char ) isCircle = false;
			}
			if( !isCircle ) continue;
			// trace( 'right found' );

			// check full circle
			for( y in y + 1...yBottom ) {
				for( x in xLeft + 1...xRight ) {
					final dist = distance( x, y, centerX, centerY );
					if( dist == r && grid[y][x] != char ) isCircle = false;
				}
			}
			if( !isCircle ) continue;
			// trace( 'circle found center $centerX:$centerY  radius $r' );
			return [centerY, centerX, r];
		}
	}
	return [];
}
*/
function createCircleCoordinates( max:Int ) {
	final circleCoords = [];
	for( r in 0...max + 1 ) {
		final length = r * 2 + 1;
		final center = r;
		final coords = [];
		for( y in 0...length ) {
			for( x in 0...length ) {
				final dist = distance( x, y, center, center );
				if( int( dist ) == r ) coords.push([x - r, y - r]);
			}
		}
		circleCoords.push( coords );
	}
	
	return circleCoords;
}

function distance( x1:Int, y1:Int, x2:Int, y2:Int ) {
	return Math.sqrt(distanceSq( x1, y1, x2, y2 ));
}

function distanceSq( x1:Int, y1:Int, x2:Int, y2:Int ) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return dx * dx + dy * dy;
}