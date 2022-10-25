import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberConvert;
using xa3.StringUtils;

/*
You are given a String, which contains letters and/or digits. You have to transform the String by converting ALL the letters first (in the order the letters appear in the string), and after that, converting the digits (in the order the digits appear in the string). The two parts are then joined together.
• Each letter is converted into its ASCII code (in base 10), and then converted to binary.
• Each digit is converted directly to binary.

Input
abcd

Output
1100001110001011000111100100
*/

function main() {

	final text = readline().split( "" );
	final letters = text.filter( s -> s.isLetter() ).map( s-> s.charCodeAt( 0 ));
	final digits = text.filter( s -> s.isNumber() ).map( s -> parseInt( s ));

	final joined = letters.concat( digits );
	final bin = joined.map( v -> v.toBin() ).join("");
	
	print( bin );
}
