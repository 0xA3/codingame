import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Your program must determine in which category belongs a given integer. The possible integers are named intervals that are also given.
The intervals do not overlap.
The integer always belongs to a category.

Input
10
3
-1000 -1 negative
0 0 null
1 1000 positive

Output
positive

*/

function main() {

	final x = parseInt( readline());
	final n = parseInt( readline());

	for( _ in 0...n ) {
		final inputs = readline().split(" ");
		if( x >= parseInt( inputs[0]) && x <= parseInt( inputs[1] )) print( inputs[2]);
	}
}
