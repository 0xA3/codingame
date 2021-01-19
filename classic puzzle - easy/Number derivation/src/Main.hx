import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		
		final result = process( n );
		print( result );
	}

	static function process( n:Int ) {
		var res = 0;
		var cpy = n;
		var p = 2;
		while( p <= cpy ) {
			// trace( 'cpy % p == 0 ? $cpy % $p = ${cpy % p}: ${cpy % p == 0}' );
			while( cpy % p == 0 ) {
				// trace( 'cpy = floor( $cpy / $p ) = ${floor( cpy / p )}' );
				cpy = floor( cpy / p );
				// trace( 'res $res += floor( $n / $p ) = ${floor( n / p )}' );
				res += floor( n / p );
			}
			p += 1;
		}
		// trace( 'return $res' );
		return res;
		
	}

}
