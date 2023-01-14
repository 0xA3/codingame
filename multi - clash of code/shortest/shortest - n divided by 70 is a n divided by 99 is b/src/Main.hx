import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Ms. CodinGame likes two integers, 70 and 99.

Find the smallest non-negative integer n such that

* the remainder of n divided by 70 is a, and
* the remainder of n divided by 99 is b.

*/

class Main {
	
	static function main() {
		
		final a = parseInt( readline());
		final b = parseInt( readline());
	
		for( n in 1...10000 ) {
			if( n % 70 == a && n % 99 == b ) {
				print( n );
				return;
			}
		}
	}
}
