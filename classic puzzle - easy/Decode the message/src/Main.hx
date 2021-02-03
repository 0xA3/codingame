import haxe.Int64;
import haxe.ValueException;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;

class Main {
	
	static function main() {
		
		final p = Int64.parseString( readline() );
		final alphabet = readline().split( "" );
		
		final result = process( p, alphabet );
		print( result );
	}

	static function process( p:Int64, alphabet:Array<String> ) {
		
		// trace( alphabet );
		
		final modulo = alphabet.length;
		final digits = [ Int64.toInt( p % modulo )];
		var value = p;
		while( value >= modulo ) {
			value = value / modulo;
			final remainder = ( value % modulo ) - 1;
			// trace( '( $value % $modulo ) - 1 = $remainder' );
			if( remainder == -1 ) digits.push( modulo - 1 );
			else digits.push( Int64.toInt( remainder ));
			
		}
		// trace( digits );
		final result = digits.map( d -> alphabet[d] ).join("");
		// trace( result );

		return result;
	}

	static function encode( text:String, alphabet:Array<String>) {
		
		final modulo = alphabet.length;
		var p:Int64 = 0;
		final char0 = text.charAt( 0 );
		p += alphabet.indexOf( char0 );

		for( i in 1...text.length ) {
			p += alphabet.indexOf( text.charAt( i )) + Int64.fromFloat( Math.pow( modulo, i ));
		}

		return p;
	}
	
}
