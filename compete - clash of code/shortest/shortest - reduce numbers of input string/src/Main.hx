import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Take every number of input and reduce it by 1
If the number is 0 remove it
*/

class Main {
	
	static function main() {
		
		final input = readline();
		var output = "";
		for( i in 0...input.length ) {
			final v = parseInt( input.charAt( i )) - 1;
			if( v > -1 ) output += v;
		}
	
		print( output );
	}
}

