import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final grid = [for( i in 0...h ) readline().split(' ')];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	// printErr( 'Grid:\n' + grid.map( row -> row.join( ' ' ) ).join( '\n' ) + "\n" );
	final outputs = [];

	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == "0" ) continue;
			
			final n = parseInt( grid[y][x] );
			// print( 'n: $n' );

			final rectangleDimensions = [for( i in 1...n + 1 ) {
				final dm = divmod( n, i );
				if( dm[1] == 0 ) {w: i, h: dm[0]};
			}];
			// printErr( rectangleDimensions );
	
			final rectanglesOfN = [];
			for( dim in rectangleDimensions ) {
				final width = dim.w;
				final height = dim.h;
				// printErr( 'width: $width height: $height' );

				for( left in x - width + 1...x + 1 ) {
					for( top in y - height + 1...y + 1 ) {
						// printErr( 'left: $left top: $top' );
						if( top < 0 || left < 0 ) continue;
						if( top + height > grid.length || left + width > grid[y].length ) continue;
						if( check4BadRectangle( grid, x, y, left, top, width, height )) continue;

						final rectangle = new Rectangle( left, top, width, height );
						rectanglesOfN.push( rectangle );
					}
				}
			}
			if( rectanglesOfN.length > 0 ) {
				final nDataset = '$y $x $n';
				outputs.push( nDataset );

				rectanglesOfN.sort( Rectangle.sort );
				for( rectangle in rectanglesOfN ) {
					outputs.push( rectangle.toOutput() );
				}
			}
		}
	}
	
	// for( output in outputs ) printErr( output );

	return outputs.join( "\n" );
}

function check4BadRectangle( grid:Array<Array<String>>, x:Int, y:Int, left:Int, top:Int, width:Int, height:Int ) {
	// printErr( 'check4BadRectangle at $x:$y [$left $top ${left + width - 1} ${top + height - 1}]' );
	for( checkX in left...left + width ) for( checkY in top...top + height ) {
		// printErr( 'pos: [$checkX $checkY] is: ${grid[checkY][checkX]}' );
		if( checkX == x && checkY == y ) continue;
		if( grid[checkY][checkX] != "0" ) {
			// printErr( 'is bad' );
			return true;
		}
	}
	// printErr( 'is not bad' );
	return false;
}

function divmod( a:Int, b:Int ) {
	return [int( a / b ), a % b];
	
}
