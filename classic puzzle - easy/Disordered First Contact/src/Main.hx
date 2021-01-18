import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final message = readline();
				
		final result = process( n, message );
		print( result );
	}

	static inline function process( n:Int, message:String ) {
		
		final mapping = createMapping( message.length );
		return n > 0 ? decode( n, message, mapping ) : encode( -n, message, mapping );
	}

	static function createMapping( length:Int ) {

		var steps = 1;
		var counter = 0;
		while( counter < length ) {
			counter += steps;
			steps++;
		}
		
		var mapping:Array<Int> = [];
		var start = 0;
		for( i in 1...steps ) {
			// trace( 'start: $start i: $i' );
			final take = [for(t in start...start + i ) if( t < length ) t];
			start += i;
			mapping = i % 2 == 0 ? take.concat( mapping ) : mapping.concat( take );
			// trace( 'take: $take mapping: $mapping' );
		}
		return mapping;
	}

	static function decode( n:Int, message:String, mapping:Array<Int> ) {
		var result = message;
		for( i in 0...n ) result = decodeOnce( result, mapping );
		return result;
	}

	static function encode( n:Int, message:String, mapping:Array<Int> ) {
		var result = message;
		for( i in 0...n ) result = encodeOnce( result, mapping );
		return result;
	}
	
	static function decodeOnce( message:String, mapping:Array<Int> ) {
		final decoded:Array<String> = [];
		for( i in 0...mapping.length ) {
			final c = mapping[i];
			// trace( 'decoded[$c] = message.charAt( $i ): ${message.charAt( i )}' );
			decoded[c] = message.charAt( i );
		}
		// trace( decoded.join("") );
		return decoded.join("");
	}

	static function encodeOnce( message:String, mapping:Array<Int> ) {
		return [for( c in mapping ) message.charAt(c)].join("");

		// final encoded:Array<String> = [];
		// for( i in 0...mapping.length ) {
		// 	final c = mapping[i];
		// 	// trace( 'encoded[$i] = message.charAt( $c ): ${message.charAt( c )}' );
		// 	encoded[i] = message.charAt( c );
		// }
		// return encoded.join("");
	}

}
