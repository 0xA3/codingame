import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static function main() {
		
		final n = readline();
		final inputs = readline().split(' ');
		final output = inputs.slice( 1, inputs.length ).concat( [inputs[0]] );
		print( '${output.join(" ")}' );
	}
}

