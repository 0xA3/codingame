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
		final rotors = [for( i in 0...3 ) CodinGame.readline().toIndexes()];
		final message = CodinGame.readline();

		CodinGame.printErr( 'operation: $operation' );
		CodinGame.printErr( 'startingShift: $startingShift' );
		CodinGame.printErr( 'message: $message' );

		final result = switch operation {
			case "ENCODE": encode( startingShift, rotors, message );
			case _: decode( startingShift, rotors, message );
		}

		CodinGame.print( result );
	}

	static function encode( startingShift:Int, rotors:Array<Array<Int>>, message:String ):String {
		
		final indexes = message.toIndexes();
		final caesar = indexes.mapi(( i, index ) -> index + startingShift + i );
		final result = rotors.fold(( rotor, indexes:Array<Int> ) -> indexes.map( c -> rotor[c % rotor.length] ), caesar );

		return result.toChars();
	}
	
	static function decode( startingShift:Int, rotors:Array<Array<Int>>, message:String ):String {
		
		final indexes = message.toIndexes();
		
		final rotorsCopy = rotors.copy();
		rotorsCopy.reverse();
		final unrotored = rotorsCopy.fold(( rotor, indexes:Array<Int> ) -> indexes.map( c -> rotor.indexOf( c )), indexes );
		
		final result = unrotored.mapi(( i, index ) -> {
			final end = ( index - startingShift - i ) % Conversion.MAX;
			final endPositive = end < 0 ? end + Conversion.MAX : end;
			return endPositive;
		});

		return result.toChars();
	}

}
