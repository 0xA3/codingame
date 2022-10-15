import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

/*
Your aim is to take in N integers, compute their sum, and output True if the digits in the sum are all unique, and False if it is not.

Input
1
10

Output
True

*/

function main() {

	final n = parseInt( readline());
	final sum = [for( _ in 0...n ) parseInt( readline())].fold(( v, sum ) -> sum + v, 0 );
	final digits = '$sum'.split("").map( s -> parseInt( s ));
	
	final integers:Map<Int,Bool> = [];
	for( digit in digits ) {
		if( integers.exists( digit ) ) {
			print( "False" );
			return;
		} else {
			integers.set( digit, true );
		}
	}

	print( "True" );
}
