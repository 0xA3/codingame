import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {
	final inputs = readline().split(' ');
	final l = parseInt( inputs[0] );
	final c = parseInt( inputs[1] );
	final n = parseInt( inputs[2] );
	final queue = [for(i in 0...n ) parseInt( readline())];
	
	final result = process( l, c, queue );
	print( result );
}

function process( l:Int, c:Int, queue:Array<Int> ) {
	// trace( 'l $l  c $c  queue $queue' );
	
	final earningsOfQueueStart = [];
	final nextStarts = [];
	// preprocess earnings
	for( queueStart in 0...queue.length ) {
		var peopleInRollerCoaster = 0;
		var groupIndex = 0;
		for( i in 0...queue.length ) {
			groupIndex = ( queueStart + i ) % queue.length;
			if( peopleInRollerCoaster + queue[groupIndex] <= l ) {
				peopleInRollerCoaster += queue[groupIndex];
			} else {
				break;
			}
		}
		earningsOfQueueStart[queueStart] = peopleInRollerCoaster;
		nextStarts[queueStart] = groupIndex;
	}

	// trace( 'earningsOfQueueStart $earningsOfQueueStart' );
	// trace( 'nextStarts $nextStarts' );

	var queueStart = 0;
	var earnings = 0.0;
	for( _ in 0...c ) {
		earnings += earningsOfQueueStart[queueStart];
		queueStart = nextStarts[queueStart];
	}

	return earnings;
}
