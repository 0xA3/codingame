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
	static final weights13 = [for( i in 0...12 ) i % 2 == 0 ? 1 : 3];

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
		if( isbn.length != 10 && isbn.length != 13 ) return false;
		return isbn.length == 10 ? validate10( isbn ) : validate13( isbn );
	}

	static function validate10( isbn:String ) {
		final checkValue = isbn.charAt( 9 ) == "X" ? 10 : parseInt( isbn.charAt( 9 ));
		if( checkValue == null ) return false;
		// trace( 'validate10 $isbn ${isbn.length}' );
		
		var sum = 0;
		for( i in 0...9 ) {
			final char = parseInt( isbn.charAt( i ));
			if( char == null ) return false;
			sum += char * weights10[i];
		}
		
		// trace( '$isbn sum $sum checkValue $checkValue ${( sum + checkValue ) % 11}' );
		return ( sum + checkValue ) % 11 == 0;
	}

	static function validate13( isbn:String ) {
		final checkValue = parseInt( isbn.charAt( 12 ));
		if( checkValue == null ) return false;
		
		var sum = 0;
		for( i in 0...12 ) {
			final char = parseInt( isbn.charAt( i ));
			if( char == null ) return false;
			sum += char * weights13[i];
		}
		
		// trace( '$isbn sum $sum checkValue $checkValue ${( sum + checkValue ) % 10}' );

		return ( sum + checkValue ) % 10 == 0;
	}
}
