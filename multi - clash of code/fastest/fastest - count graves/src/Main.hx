import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
You find yourself exploring a place, looking for your grandfather's grave.
Given a particular layout, output your chance to find it with only one try.

The place you're exploring is delimited by symbols -, +, and | as follows:
+--+
| +|
| ||
+--+
As you can see, each grave you'll be able to find inside this area is represented by a + with a | below.
You have to count the graves and give the chance (percentage, rounded) that, if you pick any of them, it will be the one you're looking for.
*/

function main() {

	final n = parseInt( readline());
	final grid = [for( i in 0...n ) readline().split( "" )];
	
	var sum = 0;
	for( y in 1...grid.length - 1 ) {
		for( x in 1...grid[y].length - 1 ) {
			if( grid[y][x] == "+" && grid[y + 1][x] == "|" ) sum++;
		}
	}

	if( sum == 0 ) {
		print( "0%" );
		return;
	}
	
	var chance = Math.round( 1 / sum * 100 );
	print( '$chance%' );
}
