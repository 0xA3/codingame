import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
import xa3.MathUtils.eval;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Given n print sum of cubes from 1 to i where 1<=i<=n on each i line.

Input
2

Output
1
9
*/

function main() {

	final n = parseInt( readline());

	var sum = 0;
	for( i in 1...n + 1 ) {
		sum += i * i * i;
		print( sum );
	}
	
}
