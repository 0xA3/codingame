import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.sqrt;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());

	final result = process( n );
	print( result );
}

function process( n:Int ) {

	// a^2 + b^2 + c^2 + d^2 = n
	// b + 3c + 5d = e^2

	final nSqrt = int( sqrt( n )) + 1;

	var total = 0;
	for( b in 0...nSqrt ) {
		for( c in 0...nSqrt ) {
			for( d in 0...nSqrt ) {
				final e = sqrt( b + 3 * c + 5 * d );
				if( e == int( e )) {
					final a2 = n - b * b - c * c - d * d;
					if( a2 >= 0 ) {
						final a = sqrt( a2 );
						if( a == int( a )) {
							final r1 = a2 + b * b + c * c + d * d;
							if( r1 == n ) total++;
						}
					}
				}
			}
		}
	}

	return total;
}
