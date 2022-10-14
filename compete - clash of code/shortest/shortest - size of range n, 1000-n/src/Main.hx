import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Output the (signed) size of the range [ N, 1000-N ]

Input
15

Output
970
*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
	
		print( 1000 - n - n );
	}
}

