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
		return n > 0 ? decode( n, message ) : encode( -n, message );
	}

	static function decode( n:Int, message:String ) {
		return "abcdefghi";
	}

	static function encode( n:Int, message:String ) {
		var result = message;
		for( i in 0...n ) result = encodeOnce( result );
		return result;
	}
	
	static function encodeOnce( message:String ) {
		var rest = message;
		var result = "";
		
		var i = 0;
		while( rest.length > 0 ) {
			i++;
			final take = rest.substr( 0, i );
			rest = rest.substring( i );
			result = i % 2 == 0 ?  take + result : result + take;
			// trace( 'take: "$take" result: "$result"' );
		}
		trace( 'length ${message.length}  i $i' );
		return result;
	}

}
