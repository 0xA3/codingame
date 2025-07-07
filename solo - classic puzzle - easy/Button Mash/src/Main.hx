import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;

function main() {
	final n = parseInt( readline() );

	final result = process( n );
	print( result );
}

function process( n:Int ) {
	var operations = 0;
	
	while( n > 0 ) {
		// if n is even, divide by 2
		if( n % 2 == 0 ) {
			n = int( n / 2 );
		} else {
			// n + 1 is divisible by 4 add 1 (except for n = 3)
			if(( n + 1 ) % 4 == 0 && n != 3 ) {
				n += 1;
			} else {
				n -= 1;
			}
		}

		operations++;
	}

	return operations;
}

