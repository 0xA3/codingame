import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
You must ouput the sum of the first N even natural numbers.
For example, if N=4 we get 2, 4, 6, 8 and the sum of these numbers is 20.

*/

function main() {

	final n = parseInt( readline());

	print( n * ( n + 1 ) );
}
