import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import haxe.Int64;

using Lambda;
using Main;
using StringTools;

function main() {
	
	final n = Int64.parseString( readline() );
	final s = Int64.parseString( readline() );
	final q = Int64.parseString( readline() );

	final result = process( n, s, q );
	print( result );
}

function process( n:Int64, s:Int64, q:Int64 ) {
	// trace( 'n: $n, s: $s, q: $q' );
	final sum = n * ( n + 1 ) / 2;
	final sumSquares = n * ( n + 1 ) * ( 2 * n + 1 ) / 6;

	final sumDifference = sum - s;
	final squareDifference = sumSquares - q;
	
	final startHigh = ( sumDifference / 2 ) + 1;
	// trace( 'sum $sum  sumDifference $sumDifference' );
	// trace( 'sumSquares $sumSquares  squareDifference $squareDifference' );
	// trace( 'startHigh $startHigh\n' );


	var i = 1i64;
	var low = i;
	var high = startHigh;

	while( i < 20 ) {
		final v1 = low + ( high - low ) / 2;
		final v2 = sumDifference - v1;

		final sq1 = v1 * v1;
		final sq2 = v2 * v2;
		
		final sqSum = sq1 + sq2;

		// trace( ' v1 $v1    v2 $v2   sumDifference ${v1 + v2}' );
		// trace( 'sq1 $sq1   sq2 $sq2  sqSum ${sq1 + sq2}' );

		if( sqSum == squareDifference ) {
			return '$v1 $v2';
		}

		if( sqSum < squareDifference ) {
			// trace( 'sqSum < squareDifference decrease high to $v1\n' );
			high = v1;
		} else {
			// trace( 'sqSum > squareDifference increase low to $v1\n' );
			low = v1;
		}
		i++;
	}

	return "0 0";
}
