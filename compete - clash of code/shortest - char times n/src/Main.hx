import haxe.xml.Printer;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		printErr( 'n $n' );
		final output = [for( _ in 0...n ) String.fromCharCode( n + 64 )].join( "" );
		print( output );
	}
}
