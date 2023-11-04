import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

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
	trace( 'l $l  c $c  queue $queue' );
	var earnings = 0.0;
	for( i in 0...c ) {
		final groupsInRollerCoaster = [];
		var peopleInRollerCoaster = 0;
		while( queue.length > 0 && peopleInRollerCoaster + queue[0] <= l ) {
			final group = queue.shift();
			groupsInRollerCoaster.push( group );
			peopleInRollerCoaster += group;
			earnings += group;
		}
		trace( '$i groups $groupsInRollerCoaster  earnings $earnings' );
		for( group in groupsInRollerCoaster ) queue.push( group );

		trace( 'queue after ride $queue' );
	}

	return earnings;
}
