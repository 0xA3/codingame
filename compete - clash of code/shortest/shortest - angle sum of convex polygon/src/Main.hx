import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Angle Sum of A Convex Polygon

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
	
		// print( n < 3 ? "ERROR" : n == 3 ? "180" : "360" );
		print( n < 3 ? "ERROR" : 180 * ( n - 2 ) );
	}
}

