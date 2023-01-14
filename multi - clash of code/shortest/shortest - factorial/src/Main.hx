import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
The program:
You will be given a positive integer N as input.
Print the factorial of N.

Input
4

Output
24

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		var fact = n;
		var x = n;
		while( x > 1 ) {
			x--;
			fact = fact * x;
		}

		print( fact );
	}
}

