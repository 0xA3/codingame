import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
Take an input integer and print:
Letters if there are more letters (a-f) in its hexadecimal representation
Digits if there are more digits (0-9); or
Equal if digits and letters are balanced

Example:
For input 29 the hex representation is 1d so the result is Equal.

Input
15

Output
Letters
*/

function main() {

	final hex = parseInt( readline()).toHex().split( "" );

	final letters = hex.filter( s -> s.isLetter() ).length;
	final digits = hex.filter( s -> s.isDigit() ).length;
	
	print( letters > digits ? "Letters" : digits > letters ? "Digits" : "Equal" );
}
