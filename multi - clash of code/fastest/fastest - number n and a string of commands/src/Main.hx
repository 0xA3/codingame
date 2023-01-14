import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
<<PROMPT>>
You start with a number n and a string of COMMANDS (message)

<<COMMANDS>>
+: adds 1 to n
-: subtracts 1 from n
H: outputs the hexadecimal representation of n
B: outputs the binary representation of n
O: outputs the octal representation of n

<<NOTE>>
If nothing is outputted during the whole process, output n

Input
35
+++H-H+H--------H+H

Output
26
25
26
1e
1f

*/

function main() {

	var n = parseInt( readline());
	final message = readline().split( "" );
	
	var hasPrinted = false;
	
	for( char in message ) {
		switch char {
			case "+": n++;
			case "-": n--;
			case "H":
				print( n.toHex() );
				hasPrinted = true;
			case "B":
				print( n.toBin() );
				hasPrinted = true;
			case "O":
				print( n.toOct() );
				hasPrinted = true;
			default: // no-op
		}
	}
	if( !hasPrinted ) print( n );
}
