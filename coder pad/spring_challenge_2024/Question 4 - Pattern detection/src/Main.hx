import Std.int;

var radWidths:Map<Int, Array<Int>> = [];
var grid:Array<Array<String>> = [];
var largestCircle = [0, 0, 0];

@:native("findLargestCircle")
@:keep function findLargestCircle( nRows:Int, nCols:Int, image:Array<String> ) {
	radWidths = initRadWidths();
	largestCircle = [0, 0, 0];
	
	// split lines
	grid = image.map( line -> line.split( "" ));
	
	// count chars in line
	for( y in 0...grid.length ) {
		final row = grid[y];
		var char = row[0];
		var left = 0;
		var right = 0;
		var col = 1;
		while( col < row.length ) {
			if( row[col] == char ) {
				right = col;
				final circle = findCircle( y, left, right, char );
				for( i in 0...circle.length ) largestCircle[i] = circle[i];
			} else {
				char = row[col];
				left = col;
				right = col;
	
			}
			col++;
		}
		if( right > left ) {
			final circle = findCircle( y, left, right, char );
			for( i in 0...circle.length ) largestCircle[i] = circle[i];
		}
	}

	return largestCircle;
}

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
			trace( 'circle found center $centerX:$centerY  radius $r' );
			return [centerY, centerX, r];
		}
	}
	return [];
}

function initRadWidths() {
	final radWidths:Map<Int, Array<Int>> = [];

	for( i in -100...0 ) {
		final r = -i;
		final length = r * 2 + 1;
		final center = r;
		var numChars = 0;
		for( x in 0...length ) {
			final dist = distance( x, 0, center, center );
			if( int( dist ) == r ) numChars++;
		}
		if( !radWidths.exists( numChars )) radWidths.set( numChars, [] );
		radWidths[numChars].push( r );
	}
	
	return radWidths;
}

function distance( x1:Int, y1:Int, x2:Int, y2:Int ) {
	return Math.sqrt(distanceSq( x1, y1, x2, y2 ));
}

function distanceSq( x1:Int, y1:Int, x2:Int, y2:Int ) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return dx * dx + dy * dy;
}