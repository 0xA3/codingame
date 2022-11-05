import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
#if js import xa3.MathUtils.eval; #end

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
A web color is represented by a number sign #, followed by three bytes, each of them represented by two hexadecimal digits, which are the rate of each Red, Green and Blue color (between 0 and 255).
You are given a hexadecimal triplet, and you have to return the value of each RGB color rate.

Input
#FF0000

Output
255
0
0

*/

function main() {

	final color = "#FF0000";// readline();

	final r = color.substr( 1, 2 ).fromHex();
	final g = color.substr( 3, 2 ).fromHex();
	final b = color.substr( 5, 2 ).fromHex();

	print( r );
	print( g );
	print( b );
}
