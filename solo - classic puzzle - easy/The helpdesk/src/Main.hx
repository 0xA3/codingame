import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;

function main() {
	final worktime = parseInt( readline() );
	final nc = parseInt( readline() );
	var inputs1 = readline().split(' ');
	final efficiencies = [for( i in 0...nc ) parseFloat( inputs1[i] )];

	final nv = parseInt( readline() );
	var inputs2 = readline().split(' ');
	final helptimes = [for( i in 0...nv ) parseInt( inputs2[i] )];
	
	final result = process( worktime, efficiencies, helptimes );
	print( result );
}

function process( worktime:Int, efficiencies:Array<Float>, helptimes:Array<Int> ) {
	trace( 'worktime $worktime  efficiencies $efficiencies  helptimes $helptimes' );
	final workers = efficiencies.mapi(( i, efficiency ) -> new Worker( i, efficiency, worktime ));

	var visitorId = 0;
	while( visitorId < helptimes.length ) {
		final visitorDuration = helptimes[visitorId];

		final nextWorker = getNextWorker( workers );
		trace( 'nextWorker: ${nextWorker.id}  free from ${nextWorker.getEndtime()}  visitor $visitorId  helptime $visitorDuration  ' );
		if( nextWorker.checkForBreak() ) nextWorker.takeABreak();
		else {
			nextWorker.work( visitorId, visitorDuration );
			visitorId++;
		}
		display( workers );
	}
	
	final outputs = [for( worker in workers ) worker.getNumCustomers()].join(" ")
	+ "\n" +
	[for( worker in workers ) worker.getNumBreaks()].join(" ");

	return outputs;
}

function display( workers:Array<Worker> ) {
	for( worker in workers ) trace( worker.toString());
}

function getNextWorker( workers:Array<Worker> ) {
	var bestStarttime = workers[0].getEndtime();
	var nextWorker = workers[0];
	for( i in 1...workers.length ) {
		final worker = workers[i];
		final starttime = worker.getEndtime();
		if( starttime < bestStarttime ) {
			bestStarttime = starttime;
			nextWorker = worker;
		}
	}
	
	return nextWorker;
}
