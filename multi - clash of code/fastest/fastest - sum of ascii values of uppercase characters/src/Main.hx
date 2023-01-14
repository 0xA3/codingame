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
Write a program to compute the sum of the ASCII values of the upper-case characters in a given string.

*/

function main() {

	final s = readline();
	var sum = 0;
	for( i in 0...s.length ) if( s.charAt( i ).isUppercase()) sum += s.charCodeAt( i );

	print( sum );
}
