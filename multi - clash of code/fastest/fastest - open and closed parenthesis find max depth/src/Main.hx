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
Given a string of open and closed parentheses, find the maximum depth of open/close parenthesis sequences. Assume that there will never be an invalid sequence with an unclosed parenthesis.

*/

function main() {

	final n = parseInt( readline());
	final sequence = readline().split( "" );
	
	var max = 0;
	var depth = 0;
	for( char in sequence ) {
		if( char == "(" ) {
			depth += 1;
			max = MathUtils.max( max, depth );
		} else if( char == ")" ) depth -= 1;
	}

	print( max );
}
