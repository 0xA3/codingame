import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;
using xa3.ArrayUtils;

/*
Given an input string s, return the character given by the average of the ASCII values of all characters in the string.
s can contain any ASCII characters, upper case letters, lower case letters, spaces or symbols.
If the average value is a float, round down (floor).

Input
5
hello

Output
j

*/

function main() {

	final lenS = parseInt( readline());
	final s = readline().split( "" );
	
	final ascii = s.map( s -> s.charCode());
	final avg = Math.floor( ascii.sum() / lenS);

	print( String.fromCharCode( avg ) );
}
