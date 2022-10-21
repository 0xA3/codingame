import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
You will be given a number num in the form of a string. You will have to multiply all the digits of the number and present it as integer output.

Input
23

Output
6
*/

function main() {

	final n = readline().split( "" ).map( s -> parseInt( s ));
	
	print( n.fold(( v, mult ) -> mult * v, 1 ) );
}
