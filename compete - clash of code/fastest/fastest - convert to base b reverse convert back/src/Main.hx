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
Given two integers b and n, convert n to base b, reverse the obtained value and then output the result x in base 10.
Input
3
5

Output
7

*/

function main() {

	final b = parseInt( readline());
	final n = parseInt( readline());

	final converted = n.toBaseN( b );
	final reversed = converted.reverse();

	print( reversed.fromBaseN( b ));
}
