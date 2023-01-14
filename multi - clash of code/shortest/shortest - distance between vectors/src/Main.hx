import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;

class Main {
	
	static function main() {
		
		var inputs = readline().split(' ');
		final x1 = parseInt(inputs[0]);
		final y1 = parseInt(inputs[1]);
		var inputs = readline().split(' ');
		final x2 = parseInt(inputs[0]);
		final y2 = parseInt(inputs[1]);

		final dx = x2 - x1;
		final dy = y2 - y1;
		final dist = Math.sqrt( dx * dx + dy * dy );
		print( Math.floor( dist ));
	}
}
