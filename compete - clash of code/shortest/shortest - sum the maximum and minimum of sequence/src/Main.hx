import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
You must sum the maximum and minimum of a sequence

Input
2
1 1

Output
2
*/

class Main {
	
	static function main() {
		
		final n = readline();
		final inputs = readline().split(" ").map( s -> parseInt( s ));
		inputs.sort(( a, b ) -> a - b );

		print( inputs[0] + inputs[inputs.length - 1] );
		
	}
}

