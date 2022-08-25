import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Build the Fibonacci Sequence but with given inputs instead of set inputs, 0 and 1. Construct an additive sequence with t, a number of times to loop, a, a first starting digit, and b, a second starting digit.

Input
10
0
1

Output
0
1
1
2
3
5
8
13
21
34
*/

class Main {
	
	static function main() {
		
		final t = parseInt( readline());
		var current = parseInt( readline());
		var next = parseInt( readline());
		print( current );
		print( next );

		for( i in 0...t - 2 ) {
			final n = next + current;
			print( n );
			
			current = next;
			next = n;
		}
	}

}

