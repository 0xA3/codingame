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
The program:
Your program must read two numbers and output the concatenation of their difference and sum.

Input
6 4
Output
210
 
*/

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	print( '${a - b}${a + b}' );
}
