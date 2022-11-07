import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Absolute value is a classical but tricky computation on integers.
Signed integers have an asymmetrical distribution between
- positive part [0 -> 2^(n-1) [
- negative part [-2^(n-1) -> -1]

Therefore absolute value has a trap where abs(-2^(n-1)) does not fit in same signed container as input.
Provide a robust absolute algorithm by saturating output in [0 -> 2^(n-1) [ range.

Input
8
1
-12

Output
12

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final m = parseInt( readline());
		for( _ in 0...m ) {
			final t = parseFloat( readline());
			if( t >= 0 ) print( t );
			else if( t <= -Math.pow(2, n - 1 )) {
				print( -t - 1 );
			} else {
				print( -t );
			}
		}
	}
}
