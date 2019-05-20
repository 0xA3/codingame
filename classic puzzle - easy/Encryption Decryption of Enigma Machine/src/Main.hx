/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Conversion;
using Lambda;

class Main {
	
	static function main() {
		
		final operation = CodinGame.readline();
		final startingShift = Std.parseInt( CodinGame.readline());
		// final rotorTexts = [for( i in 0...3 ) CodinGame.readline()];
		// final rotors = rotorTexts.map( t -> t.toIndexes());
		final rotors = [for( i in 0...3 ) CodinGame.readline().toIndexes()];
		final message = CodinGame.readline();

		CodinGame.printErr( 'operation: $operation' );
		CodinGame.printErr( 'startingShift: $startingShift' );
		// for( t in rotorTexts ) CodinGame.printErr( t );
		CodinGame.printErr( 'message: $message' );

		// final code = "A".charCodeAt( 0 );
		// final char = String.fromCharCode( code );
		// CodinGame.printErr( 'code $code  char $char' );
		
		final result = switch operation {
			case "ENCODE": encode( startingShift, rotors, message );
			case _: decode( startingShift, rotors, message );
		}

		CodinGame.print( result );
	}

	static function encode( startingShift:Int, rotors:Array<Array<Int>>, message:String ):String {
		
		final indexes = message.toIndexes();
		final caesar = indexes.mapi(( i, index ) -> index + startingShift + i );
		final rotor0 = caesar.map( c -> rotors[0][c % Conversion.MAX] );
		final rotor1 = rotor0.map( c -> rotors[1][c % Conversion.MAX] );
		final rotor2 = rotor1.map( c -> rotors[2][c % Conversion.MAX] );
		
		// CodinGame.printErr( 'message $message');
		// CodinGame.printErr( 'caesar ${caesar.toChars()}');
		// CodinGame.printErr( 'rotor0 ${rotor0.toChars()}');
		// CodinGame.printErr( 'rotor1 ${rotor1.toChars()}');
		// CodinGame.printErr( 'result ${rotor2.toChars()}');
		return rotor2.toChars();
	}
	
	static function decode( startingShift:Int, rotors:Array<Array<Int>>, message:String ):String {
		
		final indexes = message.toIndexes();
		final rotor1 = indexes.map( c -> rotors[2].indexOf( c ));
		final rotor0 = rotor1.map( c -> rotors[1].indexOf( c ));
		final caesar = rotor0.map( c -> rotors[0].indexOf( c ));
		final result = caesar.mapi(( i, index ) -> {
			final end = ( index - startingShift - i ) % Conversion.MAX;
			final endPositive = end < 0 ? end + Conversion.MAX : end;
            // CodinGame.printErr( 'index: $index  end: $end' );
			return endPositive;
		});
		// CodinGame.printErr( 'result $message');
		// CodinGame.printErr( 'rotor1 ${rotor1.toChars()}');
		// CodinGame.printErr( 'rotor0 ${rotor0.toChars()}');
		// CodinGame.printErr( 'caesar ${caesar.toChars()}');
		// CodinGame.printErr( 'message ${result.toChars()}');
		return result.toChars();
	}

}
