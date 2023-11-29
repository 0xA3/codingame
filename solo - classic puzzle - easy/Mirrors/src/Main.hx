import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using NumberFormat;

function main() {
	final n = parseInt( readline());
	final reflectivities = readline().split(" ").map( s -> parseFloat( s )).slice( 0, n );

	final result = process( reflectivities );
	print( result );
}

function process( reflectivities:Array<Float> ) {
	var t = 0.0;
	for( r in reflectivities ) {
		t = ( t + r - 2 * t * r ) / ( 1 - t * r );
		if( t == 1 ) break;
	}

	return t.fixed( 4 );
}
