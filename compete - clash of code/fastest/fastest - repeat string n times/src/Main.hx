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
Repeat the given string N times and output the result to the console

if n is 0 print "empty"
	
*/

function main() {

	final n = parseInt( readline());
	final s = readline();
	
	if( n == 0 ) print( "empty");
	else print( s.repeat( n ));
}
