import haxe.ds.GenericStack;
import haxe.macro.Expr.Case;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

final MAX_SPEED = 130;

function main() {

	final roadLength = parseInt( readline() );
	final zoneQuantity = parseInt( readline() );
	final routes:Array<Route> = [for( _ in 0...zoneQuantity ) {
		final inputs = readline().split(" ");
		{ start: parseInt( inputs[0] ), speed: parseInt( inputs[1] )}
	}];
	
	final result = process( roadLength, routes );
	print( result );
}

function process( roadLength:Int, routes:Array<Route> ) {
	final minDuration = roadLength / MAX_SPEED * 60;
	
	routes.unshift({ start: 0, speed: MAX_SPEED });
	routes.push({ start: roadLength, speed: 0 });

	final zones:Array<Zone> = [];
	for( i in 0...routes.length - 1 ) {
		final length = routes[i + 1].start - routes[i].start;
		zones.push({ length: length, speed: routes[i].speed} );
	}
	
	final durations = zones.map( zone -> zone.length / zone.speed * 60 );
	final totalDuration = durations.fold(( d, sum ) -> sum + d, 0.0 );
	final deltaDuration = totalDuration - minDuration;
	
	return Math.round( deltaDuration );
}

typedef Route = {
	final start:Int;
	final speed:Int;
}

typedef Zone = {
	final length:Int;
	final speed:Int;
}