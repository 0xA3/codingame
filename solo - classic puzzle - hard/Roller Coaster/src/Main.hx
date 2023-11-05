import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.Int64;

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
	
	final cache:Map<Int, EarningsNext> = [];

	var queueStart = 0;
	var earnings = 0i64;
	for( _ in 0...c ) {
		final earningsNext = cache.exists( queueStart )
			? cache[queueStart]
			: {
				final en = getEarningsNext( l, queue, queueStart );
				cache.set( queueStart, en );
				en;
			}
		
		earnings += earningsNext.earnings;
		queueStart = earningsNext.next;
	}

	return earnings;
}

function getEarningsNext( l:Int, queue:Array<Int>, queueStart:Int ):EarningsNext {
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
	
	return { earnings: peopleInRollerCoaster, next: groupIndex }
}

typedef EarningsNext = {
	final earnings:Int64;
	final next:Int;
}