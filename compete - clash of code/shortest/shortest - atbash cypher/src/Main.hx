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
Your program must decrypt a text encrypted with the Atbash cipher -- a simple substitution cipher.

It consists in substituting a (the first letter) for z (the last), b (the second) for y (one before last), and so on, reversing the alphabet.

*/

class Main {
	
	static function main() {
		
		final word = readline();
		
		var output = "";
		for( i in 0...word.length ) output += String.fromCharCode( 219 - word.charCodeAt( i ));
		
		print( output );
	}
}
