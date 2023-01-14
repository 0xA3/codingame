import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseFloat;
import Std.int;
import Math.round;

/*
For a given input integer n as start of the Collatz Sequence do:
n=n/2 for even n (divisible by 2) and
n=3*n+1 for odd n (not divisible by 2)
until n=1
Count the number of different n if takes to reach n=1 and use this number as a new start value for n and repeat the process one more time. Print the number of different n of that second Collatz-Sequence. In one Collatz-Sequence there are only different n values.

Example:
n=5
Sequence: 5->16->8->4->2->1
=> n=6
Sequence: 6->3->10->5->16->8->4->2->1
=> n=9 ==>The result is 9
*/

class Main {
	
	static function main() {
		
		final n = collatz( collatz( parseFloat( readline() ) ));

		print( n );
	}

	static function collatz( n:Float ) {
		var c = 1;
		while( n > 1 ) {
			n = n % 2 == 0 ? n / 2 : 3 * n + 1;
			c++;
		}
		return c;
	}
}
