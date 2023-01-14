import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final lines = [for( _ in 0...h ) readline().split( "" )];

	final result = process( w, h, lines );
	print( result );
}

function process( width:Int, height:Int, lines:Array<Array<String>> ) {

	final probabilities = [];
	for( y in 0...lines.length ) {
		for( x in 0...lines[y].length ) {
			if( lines[y][x] == "G" ) {
				final probability = min( x, y ) / ( x * x + y * y + 1 );
				probabilities.push( probability );
			}
		}
	}
	probabilities.sort(( a, b ) -> a < b ? -1 : 1 );
	
	var totalP = 0.0;
	for( i in 0...probabilities.length ) {
		final p = probabilities[i];
		totalP = totalP + p - totalP * p;
		// trace( '$i totalP $totalP' );
		if( totalP > 0.4 ) return i;
	}

	return 0;
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;