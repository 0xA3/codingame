import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.MathUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Count the number of ones in the binary representation of each given integer.

*/

function main() {

	final n = parseInt( readline());
	for( _ in 0...n ) {
		final bin = parseInt( readline()).toBin();
		print( bin.count("1"));
	}

}
