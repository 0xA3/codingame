import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final text = [for( i in 0...n ) readline()].join( "\n" );

		final result = process( text );
		print( result );
	}

	static function process( text:String ) {
		
		final parser = new Parser();
		final exprs = parser.parse( text );
		
		final output = Interp.execute( exprs );
		// trace( "\n" + output );
		return output;
	}

}
