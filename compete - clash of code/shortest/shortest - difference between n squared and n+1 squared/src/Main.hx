import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Print the absolute difference between n^2 and (n + 1)^2

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		print( n * 2 + 1 );
	}
}

