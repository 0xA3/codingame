import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
A Fibonacci sequence starts with two given terms and each subsequent term is the sum of the previous two terms.

You must output a specific term of a Fibonacci sequence given its first two terms.

Input
2
3
4

Output
13
*/

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final n = parseInt( readline());
	
	final sequence = MathUtils.fibonacci( a, b, n );
	print( sequence[n] );
}
