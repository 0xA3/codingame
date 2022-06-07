import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static function main() {
		
		final input = readline().split( "" );
		var v = 0;
		for( s in input ) {
			final v2 = parseInt( s );
			if( v2 >= v ) v = v2;
			else {
				print( false );
				return;
			}
		}
		print( true );
	}
}

