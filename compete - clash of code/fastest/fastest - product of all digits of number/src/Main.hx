import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

/*
Print the product of all digits of a number n.

*/

function main() {

	final n = readline().split("").map( s -> parseInt( s )).fold(( v, prod ) -> prod * v, 1 );
	
	print( n );
}
