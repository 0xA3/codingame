import haxe.Int64;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
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
		final digits = [];
		var value = p;
		while( value >= 0 ) {
			digits.push( alphabet[Int64.toInt( value % modulo )] );
			value = ( value - value % modulo ) / modulo - 1;
			
		}
		// trace( digits );
		final result = digits.join("");
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
