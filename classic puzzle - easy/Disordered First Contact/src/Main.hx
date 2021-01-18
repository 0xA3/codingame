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
		
		var steps = 1;
		var counter = 0;
		while( counter < message.length ) {
			counter += steps;
			steps++;
		}
		trace( 'length ${message.length}  steps ${steps - 1}' );
		// final mapping = createMapping( message.length );

		return n > 0 ? decode( n, message, steps ) : encode( -n, message, steps );
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
			final take = [for(t in start...start + i ) if( i < length ) t];
			start += i;
			mapping = i % 2 == 0 ? take.concat( mapping ) : mapping.concat( take );
			// trace( 'take: $take mapping: $mapping' );
		}
		// trace( mapping );
		return mapping;
	}

	static function decode( n:Int, message:String, steps:Int ) {
		var result = message;
		for( i in 0...n ) result = decodeOnce( result, steps );
		return result;
		return "abcdefghi";
	}

	static function encode( n:Int, message:String, steps:Int ) {
		var result = message;
		for( i in 0...n ) result = encodeOnce( result, steps );
		return result;
	}
	
	static function decodeOnce( message:String, steps:Int ) {

		var result = "";
		var start = 0;
		return "";
	}

	static function encodeOnce( message:String, steps:Int ) {
		
		var result = "";
		var start = 0;
		for( i in 1...steps ) {
			final take = message.substr( start, i );
			start += i;
			result = i % 2 == 0 ?  take + result : result + take;
			// trace( 'take: "$take" result: "$result"' );
		}

		return result;
	}

}
