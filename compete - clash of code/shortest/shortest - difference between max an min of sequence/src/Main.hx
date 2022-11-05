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
You have to find the differences between the maximum and the minimum value of the given sequence.
Input
4
13 14 21 25

Output
12
*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final inputs = readline().split(" ");

		var max = 0;
		var min = 100;
		for( i in 0...inputs.length ) {
			final v = parseInt( inputs[i] );
			if( v > max ) max = v;
			if( v < min ) min = v;
		}
	
		print( max - min );
	}
}
