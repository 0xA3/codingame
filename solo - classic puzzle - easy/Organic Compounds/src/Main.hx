import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final lines = [for( i in 0...n ) readline()];
				
		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		// trace( "\n" + lines.join( "\n" ));

		final parser = new FormulaParser( lines );
		final isValid = parser.parse();

		return isValid ? "VALID" : "INVALID";
	}

}
