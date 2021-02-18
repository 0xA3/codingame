import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.log;

using Lambda;

function main() {
	
	final n = parseInt( readline() ); // number of capitals
	
	final result = process( n );
	print( result );
}

function processReference( n:Int  ) {
	
	// Reference implementation only usable for small values
	final a = [for( i in 1...n + 1) i];
	// trace( a );
	while( a.length > 1 ) {
		a.shift();
		// printErr( "➀ throw away the top card\n" + a );
		final first = a.shift();
		a.push( first );
		// printErr( "② move the current top card to the bottom\n" + a );
	}
	// trace( 'n $n result ${a[0]}' );
	return a[0];

}

function log2( n:Int ) return log( n ) / log( 2 );

function process( n:Int ) {
	
	if( n == 1 ) return 1;

	final base = int( log2( n ));
	final offset = int( n - Math.pow( 2, base ));
	return offset == 0 ? n : offset * 2;
}
