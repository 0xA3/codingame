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
For each of my N children, according to my parentAge and their childAge, I want to know how old I'll be when I'll be 2 times their age.

Input
30
1
10

40
*/

function main() {

	final fatherAge = parseInt( readline());
	final n = parseInt( readline());
	
	// f + x = 2 * ( c + x )
	// f + x = 2c + 2x
	// x = 2c + 2x - f
	// x - 2x = 2c - f
	// -x = 2c - f
	// x = f - 2c
	
	for( i in 0...n ) {
		final childAge = parseInt( readline() );
		print( fatherAge + fatherAge - 2 * childAge );
	}
}
