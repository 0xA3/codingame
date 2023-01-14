import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Print the square of the sum of the numbers given

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		var sum = 0;
		for( _ in 0...n ) sum += parseInt( readline());
		print( sum * sum );
	}
}

