import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Your program must create the lowest integer from the input with the choice of subtracting each digit from 9 or not.

For example, 17 can become 12 by replacing the digit 7 by 2 (because 9 - 7 = 2).

Input
169

Output
130

*/

class Main {
	
	static function main() {
		
		final digits = readline().split( "" );
		var outputs = [];
		for( digit in digits ) {
			final v = parseInt( digit );
			outputs.push( v < 5 ? v : 9 - v );
		}
		print( outputs.join( "" ));
	}
}
