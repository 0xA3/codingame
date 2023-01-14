import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;

function main() {

	final n = parseInt( readline() );
	final incomingLoad = parseInt( readline() );
	final inputs = readline().split( " " );
	final currentLoads = [for( i in 0...n ) parseInt( inputs[i] )];

	final result = process( currentLoads, incomingLoad );
	print( result );
}

function process1( currentLoads:Array<Int>, incomingLoad:Int ) {

	final tempLoads = currentLoads.copy();
	tempLoads.sort( ( a, b ) -> a - b );

	// trace( tempLoads );

	var restLoad = incomingLoad;
	var lowestLoad = tempLoads[0];
	for( i in 1...tempLoads.length ) {

		final dLoad = tempLoads[i] - tempLoads[i - 1];
		if( dLoad == 0 ) continue;
		final maxReduction = dLoad * i;
		// final partials = [for( o in 0...i + 1 ) tempLoads[o]].join( " " );

		if( maxReduction <= restLoad ) {
			final additionPerServer = int( maxReduction / i );
			lowestLoad += additionPerServer;
			for( o in 0...i ) tempLoads[o] += additionPerServer;
			restLoad -= additionPerServer * i;
			// trace( '${tempLoads[i - 1]}-${tempLoads[i]}\n                    dLoad: $dLoad, maxReduction: $maxReduction, restLoad: $restLoad, lowestLoad: $lowestLoad' );
			// trace( '[$partials]\n                    dLoad: $dLoad, maxReduction: $maxReduction, restLoad: $restLoad, lowestLoad: $lowestLoad' );
		} else {
			final additionPerServer = int( restLoad / i );
			lowestLoad += additionPerServer;
			for( o in -i + 1...1 ) {
				tempLoads[-o] += additionPerServer;
				restLoad -= additionPerServer;
				if( restLoad <= 0 ) break;
			}
			restLoad -= additionPerServer * i;

			if( restLoad <= 0 ) break;
			// trace( '${tempLoads[i - 1]}-${tempLoads[i]}\n                    dLoad: $dLoad, maxReduction: $maxReduction, restLoad: $restLoad, lowestLoad: $lowestLoad' );
			// trace( '[$partials]\n                    dLoad: $dLoad, maxReduction: $maxReduction, restLoad: $restLoad, lowestLoad: $lowestLoad' );
		}
	}
	// trace( '[${tempLoads.join( " " )}]' );
	final imbalance = tempLoads[tempLoads.length - 1] - tempLoads[0];
	// trace( 'imbalance = ${tempLoads[tempLoads.length - 1]} - ${tempLoads[0]} = $imbalance' );
	return imbalance == 0 ? 1 : imbalance;
}

function process( currentLoads:Array<Int>, incomingLoad:Int ) {
	final n = currentLoads.length;
	final l = currentLoads.copy();
	l.sort( ( a, b ) -> a - b );

	var k = incomingLoad;
	for( i in 0...n - 1 ) {
		final fill = ( l[i + 1] - l[i] ) * ( i + 1 );
		if( fill <= k ) k -= fill;
		else return l[n - 1] - l[i] - int( k / ( i + 1 ) );
	}

	return k % l.length == 0 ? 0 : 1;
}
