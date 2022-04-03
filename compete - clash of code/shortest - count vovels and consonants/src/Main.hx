import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;
import Std.int;
import Math.round;

class Main {
	
	static function main() {
		
		final string = readline().toLowerCase();
		var vNum = 0;
		var cNum = 0;
		for( i in 0...string.length ) {
			final char = string.charAt( i );
			if( char == " " ) {}
			else if( "aeiouy".split("").contains( char )) vNum++;
			else cNum++;
		}
		print( vNum > cNum ? "vowels" : "consonants" );
	}
}

