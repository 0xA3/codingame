import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline() );
	final inputs = readline().split(' ');
	final prices = [for( i in 0...n ) parseInt( inputs[i] )];
				
	final result = process( prices );
	print( result );
}

function process( prices:Array<Int> ) {

	final priceDifs = [for( i in 1...prices.length) prices[i] - prices[i - 1]];
	final maxLosses = [priceDifs[0]];
	// trace( 'prices $prices' );
	// trace( 'priceDifs $priceDifs' );

	for( i in 1...priceDifs.length ) {
		maxLosses[i] = min( priceDifs[i], maxLosses[i - 1] + priceDifs[i] );
		// trace( '$i maxLosses[${i - 1}](${maxLosses[i - 1]}) + priceDifs[$i](${priceDifs[i]}): ${maxLosses[i - 1] + priceDifs[i]}  min ${maxLosses[i]}' );
	}

	final maxLoss = maxLosses.fold(( v, m ) -> min( v, m ), 0 );
	// trace( 'maxLosses $maxLosses' );
	// trace( 'maxLoss $maxLoss' );

	return maxLoss;
}

function min( v1:Int, v2:Int ) {
	return v1 < v2 ? v1 : v2;
}
