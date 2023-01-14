import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
You will be given a string of digits to add up. Start adding them up, but if at any time one of the digits is 0, reset the sum back to 0.
*/

function main() {

	final n = parseInt( readline());
	final output = readline()
	.split( "" )
	.map( s -> parseInt( s ))
	.fold(( v, sum ) -> v > 0 ? sum + v : 0, 0 );

	print( output );
}
