import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var LENGTH = 16;
	static inline var LENGTH_HALF = int( LENGTH / 2 );

	static function main() {
		
		final n = parseInt(readline());
		final cards = [for( i in 0...n ) readline()];
		
		final result = process( cards );
		print( result );
	}

	static function process( cards:Array<String> ) {
		
		final areValid = cards.map( card -> validate( card.replace(" ", "" ).split( "" ).map( d -> parseInt( d ))));
		return areValid.map( isValid -> isValid ? "YES" : "NO" ).join( "\n" );
	}

	static function validate( digits:Array<Int> ) {
		
		final processedSecondDigitSum = [for( i in 0...LENGTH_HALF) digits[i * 2]]
			.map( digit -> digit * 2 )
			.map( digit -> digit >= 10 ? digit - 9 : digit )
			.fold(( digit, sum ) -> sum + digit, 0 );
		
		final oddDigitSum = [for( i in 0...LENGTH_HALF) digits[i * 2 + 1]]
			.fold(( digit, sum ) -> sum + digit, 0 );

		final isValid = ( processedSecondDigitSum + oddDigitSum ) % 10 == 0;
		
		return isValid;
	}

}
