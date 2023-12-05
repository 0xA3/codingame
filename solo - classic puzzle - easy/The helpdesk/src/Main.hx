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

	for( customer in helptimes ) {
		final currentWorker = workers[0];
		var nextEndTime = currentWorker.getEndtime();
		var nextWorkerId = 0;
		for( i in 0...workers.length ) {
			final workerId = i % workers.length;
			final worker = workers[workerId];
			final workerEndtime = worker.getEndtime();
			if( workerEndtime < nextEndTime ) {
				nextEndTime = workerEndtime;
				nextWorkerId = workerId;
			}
		}
		final workerEndtimes = workers.mapi(( i, worker ) -> '$i: ${worker.getEndtime()}' ).join("  ");
		if( nextWorkerId == 4 ) {
			trace( 'workerEndtimes $workerEndtimes' );
			trace( 'nextWorkerId $nextWorkerId' );

		}
		final nextWorker = workers[nextWorkerId];
		nextWorker.assignCustomer( customer );
	}
	
	for( i in 0...workers.length ) trace( '$i  ${workers[i]}' );

	final outputs = [for( worker in workers ) worker.customers].join(" ")
	+ "\n" +
	[for( worker in workers ) worker.breaks].join(" ");

	return outputs;
}
