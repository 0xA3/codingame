import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;

/*
The population c increases 10% every year
Calculate to population after n years

*/

class Main {
	
	static function main() {
		
		var c = parseFloat( readline());
		final n = parseInt( readline());
	
		for( _ in 0...n ) c *= 1.1;
		print( int( c ) );
	}
}
