import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final w = parseInt(inputs[0]);
	final h = parseInt(inputs[1]);
	final fill = readline();
	final empty = readline();
	
	if( h % 2 != 1 || w < 1 || h < 1 ) {
		print( "Invalid Input" );
	} else if( h == 1 ) {
		print( [for( _ in 0...w ) fill].join( "" ));
	} else {
		final grid = [];
		for( y in 0...h ) {
			grid[y] = [];
			for( x in 0...w ) grid[y][x] = empty;
		}
	
		var y = int( h / 2 );
		var delta = -1;
		for( x in 0...w ) {
			grid[y][x] = fill;
			if( y == 0 ) delta = 1;
			if( y == h - 1 ) delta = -1;
			y += delta;
		}
		print( grid.map( a -> a.join("")).join( "\n" ));
	}
}
