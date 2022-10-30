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
Output distance traveled in meters

with input speed in centimeters / s
and time in minutes

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		for( _ in 0...n ) {
			final inputs = readline().split(" ");
			print( parseInt( inputs[0] ) / 100 * parseInt( inputs[1] ) * 60 );
		}
	}
}
