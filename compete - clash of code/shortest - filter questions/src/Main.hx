import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static function main() {
		
		final questionPrefix = readline();
		final n = parseInt( readline() );
		final questions = [for( i in 0...n ) readline()];

		var foundMatch = false;
		for( question in questions ) {
			if( question.substr( 0, questionPrefix.length ) == questionPrefix ) {
				print( question );
				foundMatch = true;
			}
		}
		if( !foundMatch ) print( "EMPTY" );
	}
}

