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
You need to simplify the fraction
The numerator is the top number in a fraction and the denominator is the one bellow the line.

If you don't know how to simplify a fraction, this is how you do it with a example:
If numerator is 4 and denominator is 6 the you can figure out that the greatest common factor between them is 2. With that information, You can figure out that the fraction is (4/2)/(6/2) and you should output 2/3.

Input
4
6

Output
2/3

*/

class Main {
	
	static function main() {
		
		final numerator = parseInt( readline());
		final denominator = parseInt( readline());
	
		final gcd = MathUtils.greatestCommonFactor( numerator, denominator );

		print( '${numerator/gcd}/${denominator/gcd}' );
	}
}
