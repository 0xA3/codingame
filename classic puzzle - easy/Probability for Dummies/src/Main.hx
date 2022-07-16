import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final m = parseInt( readline() );
	final n = parseInt( readline() );

	final result = process( m, n );
	print( result );
}

function process( differentNumbers:Int, spins:Int ) {

	final randoms = [for( i in 0...spins ) 0];
	final results = new List<Int>();

	for( _ in 0...10000 ) {
		for( i in 0...spins ) {
			final random = Std.random( 38 );
			randoms[i] = random;
		}
		final differentRandoms = [];
		for( r in randoms ) if( !differentRandoms.contains( r )) differentRandoms.push( r );
		results.add( differentRandoms.length );
	}

	var sum = 0;
	for( r in results ) if( r >= differentNumbers ) sum++;

	return '${Math.round( sum / 100 )}%';
}
