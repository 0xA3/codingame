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
Finally, scientists have invented a 4-state boolean: The Quoolean. It is an 8-bit integer number, which will evaluate to one of its four states of thruthness, based on it's binary representation:
true -> All ones.
trueish -> More ones than zeros, or equal ones and zeros.
falsish -> More zeros than ones.
false -> All zeros.

As the intern in the company, You are tasked with writing an Quoolean evaluator which will output its state of truthness as a string, based on the input.

For example: 20 -> 00010100 -> falsish

Input
20

Output
falsish
*/

function main() {

	final q = parseInt( readline()).toBin();
	final quoolean = "0".repeat( 8 - q.length ) + q;
	printErr( quoolean );

	final ones = quoolean.count( "1" );
	final zeros = quoolean.count( "0" );

	if( ones == 8 ) print( true );
	else if( zeros == 8 ) print( false );
	else if( ones >= zeros) print( "trueish" );
	else print( "falsish" );
}
