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
Goal
You must output the surface area of the given dimensions of a rectangular prism, cuboid, or box

Input
3
4
5

Output
94

*/

function main() {

	final length = parseInt( readline());
	final width = parseInt( readline());
	final height = parseInt( readline());

	print( 2 * ( width * length + length * height + height * width ));
	
}
