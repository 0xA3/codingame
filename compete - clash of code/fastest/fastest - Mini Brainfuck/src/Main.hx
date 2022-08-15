import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
Brainf**k is a programming language designed to be extremely lightweight. Your task is to create an interpreter for Mini Brainf**k which features just three commands:

+ Adds one to the value
- Takes one from the value
. Outputs the character representation of the ASCII value

Note that any characters that are not commands are ignored, allowing easy notation.

*/

function main() {

	final chars = readline().split( "" );
	
	var output = "";
	var v = 0;
	for( c in chars ) {
		switch c {
			case "+": v++;
			case "-": v--;
			case ".": output += String.fromCharCode( v );
		}
	}

	print( output );
}
