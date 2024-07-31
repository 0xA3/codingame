import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.Int64.parseString;
import haxe.Int64;

using MathUtils;

function main() {
	final n = parseString( readline() ); // Number of tiles in the tile set
	
	final result = process( n );
	print( result );
}

function process( n:Int64 ) {
	final fibs = [1i64, 2i64];
	while( fibs[fibs.length - 1] < n ) {
		fibs.push( fibs[fibs.length - 1] + fibs[fibs.length - 2] );
	}

	fibs.reverse();

	final outputs = [];
	var tempN = n;
	for( f in fibs ) {
		if( f <= tempN ) {
			outputs.push( f );
			tempN -= f;
		}
	}

	return outputs.map( v -> '$v' ).join( "+" );
}
