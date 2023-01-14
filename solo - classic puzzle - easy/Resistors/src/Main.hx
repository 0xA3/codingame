import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.parseFloat;

using NumberFormat;

class Main {
	
	static var char:Int;
	
	static function main() {
		
		final n = parseInt( readline() );
		final resistors:Map<String, Float> = [];
		for( i in 0...n ) {
			var inputs = readline().split(' ');
			final name = inputs[0];
			final r = parseFloat( inputs[1] );
			resistors.set( name, r );
		}
		final circuit = readline();
		
		final result = process( resistors, circuit );
		print( result );

	}

	static function process( resistors:Map<String, Float>, circuit:String ) {
		
		final parser = new Parser();
		final ast = parser.parse( circuit );
		
		final interpreter = new Interpreter( resistors );
		final result = interpreter.execute( ast );

		return result.number( 1 );
	}


}

