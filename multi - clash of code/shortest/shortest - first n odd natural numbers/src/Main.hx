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
Your task is to find the sum of the first N odd natural numbers.

Input
1

Output
1

14
196

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
	
		var sum = 0;
		var i = 1;
		while( i < n * 2 ) {
			sum += i;
			// printErr( 'i $i  sum $sum' );
			i += 2;
		}
		
		print( sum );
	}
}
