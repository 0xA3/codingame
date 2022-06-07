import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final s = parseInt( readline() );
	final inputs = readline().split(' ');
	final tasks = [for( i in 0...s ) parseInt( inputs[i] )];

	final timeOfWorker = [for( _ in 0...n ) 0];
	for( taskTime in tasks ) {
		timeOfWorker.sort(( a, b ) -> a - b );
		printErr( '$timeOfWorker' );
		timeOfWorker[0] += taskTime;
	}
	timeOfWorker.sort(( a, b ) -> b - a );
	print( '${timeOfWorker[0]}' );
}
