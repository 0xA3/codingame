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

Your program must sort an array of integers in ascending order. The integers are bound within [-1000000,1000000].

Input
5
5 4 9 2 7

Output
2 4 5 7 9

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final inputs = readline().split(" ").map( s -> parseInt( s ));
		inputs.sort(( a, b ) -> a - b );
	
		print( inputs.join(" ") );
	}
}
