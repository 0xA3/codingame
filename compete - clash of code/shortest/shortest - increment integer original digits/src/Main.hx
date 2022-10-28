import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;
import Std.string;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Increment the given integer by one until the original digits don't show up.

Input
7

Output
8
*/

class Main {
	
	static function main() {
		
		final input = readline();
		var n = parseInt( input );

		final s0 = input.split( "" );
		while( true ) {
			n++;
			final s1 = string( n ).split( "" );
			var found = false;
			for( digit in s1 ) {
				if( s0.contains( digit )) {
					found = true;
					break;
				}
			}
			if( !found ) {
				break;
			}
		}

		print( n );
	}
}

