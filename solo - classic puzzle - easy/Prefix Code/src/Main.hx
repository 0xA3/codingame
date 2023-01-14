import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static var char:Int;

	static function main() {
		
		final codes:Map<String, Int> = [];
		
		final n = parseInt(readline());
		for( i in 0...n ) {
			var inputs = readline().split(' ');
			final b = inputs[0];
			final c = parseInt(inputs[1]);

			printErr( 'b: $b, c: $c' );
			codes.set( b, c );
		}
		final encodedString = readline();
		printErr( encodedString );

		final result = process( codes, encodedString );
		print( result );

	}

	static function process( codes:Map<String, Int>, encodedString:String ) {
		
		var maxLength = getMaxLength( [for( s in codes.keys()) s ]);
		final input = new haxe.io.StringInput( encodedString );

		char = -1;
		var code = "";
		var output:Array<String> = [];

		var i = 0;
		while( true ) {
			try {
				code += String.fromCharCode( input.readByte());
				// printErr( 'code $code' );
			} catch( e:Dynamic ) {
				// trace( 'code: "$code", output "${output.join('')}", length ${output.length}' );
				if( code != "" ) return 'DECODE FAIL AT INDEX $i';
				break;
			}

			if( code.length > maxLength ) return 'DECODE FAIL AT INDEX $i';

			if( codes.exists( code )) {
				// trace( 'i $i code $code string ${String.fromCharCode( codes[code] )}' );
				output.push( String.fromCharCode( codes[code] ));
				i+= code.length;
				code = "";
			}
		}
		
		final result = output.join( "" );
		// printErr( result );
		return result;
	}

	static function getMaxLength( a:Array<String> ) {
		return a.fold(( s, max ) -> s.length > max ? s.length : max, 0 );
	}

}
