import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
We define a transformation of digits as being from "0123456789" to "9876543210".
You're given N digits as input. Please transform the digits in a similar way.
For example, if you're given the digit 1, you should output the digit 8.

Input
1
8

Output
1
*/

function main() {

	final code = "0123456789";
	final decode = "9876543210";

	final n = parseInt( readline());

	for( _ in 0...n ) {
		final index = code.indexOf( readline() );
		print( decode.charAt( index ));
	}
}
