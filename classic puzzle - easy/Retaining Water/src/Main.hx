import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.log;
import Math.max;
import Math.min;
import Std.int;
import Std.parseInt;

using ArrayUtils;
using Lambda;

inline var MAX_VALUE = 26;

function main() {
	
	final n = parseInt( readline() );
	final grid = [for( i in 0...n ) readline().split("").map( char -> char.charCodeAt( 0 ) - 64 )];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<Int>> ) {
	if( grid == null || grid.length == 0 ) return 0;

	final height = grid.length;
	final width = grid[0].length;

	final surface:Array<Array<Int>> = [for( y in 0...grid.length) [for( x in 0... grid[y].length ) {
		if( x == 0 || y == 0 || x == width - 1 || y == height - 1 ) grid[y][x];
		else MAX_VALUE;
	}]];
	
	// printErr( "\n" + surfaceToString( surface ));

	var repeat = true;
	while( repeat ) {
		repeat = false;
		for( y in 1...height - 1 ) {
			for( x in 1...width - 1 ) {
				final top = surface[y - 1][x];
				final left = surface[y][x - 1];
				final bottom = surface[y + 1][x];
				final right = surface[y][x + 1];
				final neighborMin = [top, left, bottom, right].min();
				// trace( '$x:$y top $top left $left bottom $bottom right $right neighborMin $neighborMin' );
				if( neighborMin < surface[y][x] ) {
					// trace( 'set $x:$y to ${int( max( neighborMin, grid[y][x] ))}' );
					if( surface[y][x] > grid[y][x] ) {
						surface[y][x] = int( max( grid[y][x], neighborMin ));
						repeat = true;
					}
				}
			}
		}
		// printErr( "\n" + surfaceToString( surface ));
	}
	
	var totalVolume = 0;
	for( y in 1...height - 1 ) {
		for( x in 1...width - 1 ) {
			final volume = surface[y][x] - grid[y][x];
			totalVolume += volume;
			// trace( '$x:$y volume $volume' );
		}
	}
	return totalVolume;
}

function surfaceToString( surface:Array<Array<Int>> ) {
	return surface.map( row -> row.map( cell -> String.fromCharCode( cell + 64 )).join( "" )).join( "\n" );
}