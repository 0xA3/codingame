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
You need to reverse the "my_d3f1n1t10n_0f_wh4t_4_w0rd_1s" (An uninterrupted string of characters from a-z, A-Z, 0-9, including the _ (underscore) character) keeping the punctuation of the text.

Input
Hello, How Are You?

Output
olleH, woH erA uoY?

*/

function main() {

	final line = readline();
	
	print( process( line ));
}

function process( line:String ) {
	
	var reversed = "";
	var buffer = "";
	
	for( i in 0...line.length ) {
		final char = line.charAt( i );
		if( char.isLetter() || char.isDigit() || char == "_" ) {
			buffer = char + buffer;
		} else {
			reversed += buffer;
			buffer = "";
			reversed += char;
		}
	}
	reversed += buffer;
	
	return reversed;
}