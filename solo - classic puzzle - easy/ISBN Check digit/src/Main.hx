import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static final weights10 = [for( i in 0...10 ) 10 - i];
	static final weights13 = [for( i in 0...13 ) i % 2 == 0 ? 1 : 3];

	static function main() {
		
		final n = parseInt( readline() );
		final isbns = [for( i in 0...n ) readline() ];
		
		final result = process( isbns );
		print( result );
	}

	static function process( isbns:Array<String> ) {
		
		final areValid = isbns.map( isbn -> validate( isbn ));
		final invalidNo = areValid.filter( isValid -> !isValid ).length;

		final invalidIsbns = [for( i in 0...isbns.length ) if( !areValid[i]) isbns[i]];
		
		final result = '$invalidNo invalid:\n' + invalidIsbns.join( "\n" );

		return result;
	}

	static function validate( isbn:String ) {
		if( isbn.length == 10 ) return validate10( isbn );
		else if( isbn.length == 13 ) return validate13( isbn );
		else return false;
	}

	static function validate10( isbn:String ) {
		var sum = 0;
		for( i in 0...isbn.length ) {
			final char = i == 9 && isbn.charAt( i ) == "X" ? 10 : parseInt( isbn.charAt( i ));
			if( char == null ) return false;
			sum += char * weights10[i];
		}
		
		// trace( '$isbn sum $sum ${sum % 11 == 0}' );
		return sum % 11 == 0;
	}

	static function validate13( isbn:String ) {
		var sum = 0;
		for( i in 0...isbn.length ) {
			final char = parseInt( isbn.charAt( i ));
			if( char == null ) return false;
			sum += char * weights13[i];
		}
		
		// trace( '$isbn sum $sum ${sum % 10 == 0}' );
		return sum % 10 == 0;
	}
}
