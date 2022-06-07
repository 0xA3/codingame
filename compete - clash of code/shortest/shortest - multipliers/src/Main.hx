import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.max;

class Main {
	
	static function main() {
		
		final inputs = readline().split(" ");
		final a = parseInt(inputs[0]);
		final b = parseInt(inputs[1]);
		final c = parseInt(inputs[2]);

		final p1 = a * b;
		final p2 = a * c;
		final p3 = b * c;
		final m = max( p1, max( p2, p3 ));
		print( '$m' );
	}
}

