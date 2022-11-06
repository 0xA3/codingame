import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;
import Math.pow;

/*
The greatest common divisor (GCD) of two integers, which are not all zero, is the largest positive integer that divides each of the integers.


Compute the greatest common divisor of |N|to the power of|M| and |M|to the power of|N| where N and M are given integers.

Note: 0 power 0 equals 1

Input
2
6


*/

class Main {
	
	static function main() {
		
		final n = MathUtils.abs( parseInt( readline()));
		final m = MathUtils.abs( parseInt( readline()));

		final p1 = int( pow( n, m ));
		final p2 = int( pow( m, n ));
	
		print( MathUtils.greatestCommonFactor( p1, p2 ) );
	}
}
