import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final n = parseInt( readline() );
	final k = parseInt( readline() );

	final result = process( n, k );
	print( result );
}

function process( n:Int, k:Int ) {
	// printErr( 'number: ' + n + ' digit: ' + k );
	var count = 0;
	var f = 1;
	while( f <= n ) {
		final high = int( n / ( f * 10 ));
		final cur = int( n / f ) % 10;
		final low = n % f;
		// printErr( '\n---------- f: $f ----------' );
		// printErr( 'n//(f*10): $n // ${f * 10} = $high' );
		// printErr( 'count = $count + $high * $f = ${count + high * f}\n' );
		count += high * f;
		
		// printErr( '(n//f)%10: ${int( n / f )} % 10 = $cur' );
		// printErr( '    n % f: $n % $f = ${n % f}' );
		// if( cur == k ) printErr( '$cur == $k   count = $count + $low + 1 = ${count + low + 1}' );
		// else printErr( '$cur != $k' );
		if( cur == k ) count += low + 1;
		
		// if( cur > k ) printErr( '$cur > $k   count = $count + $f = ${count + f}' );
		// else if( cur != k ) printErr( '$cur < $k' );
		if( cur > k ) count += f;
		f *= 10;
	}
	// printErr( 'final count = $count' );
	return count;
}
