import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import haxe.Int64;

using Lambda;

function main() {

	final n = parseInt( readline() );
	final xPositions = [];
	final yPositions = [];
	for( i in 0...n ) {
		final inputs = readline().split(' ');
		xPositions.push( Int64.parseString( inputs[0] ));
		yPositions.push( Int64.parseString( inputs[1] ));
	}
	final result = process( xPositions, yPositions );
	print( result );
}

function process( xPositions:Array<Int64>, yPositions:Array<Int64> ) {

	final xBounds = getBounds( xPositions );
	final median = getMedian( yPositions );
	final centerLength = xBounds.max - xBounds.min;
	final cableLengths = yPositions.map( v -> abs( v - median ));
	final totalCablesLength = cableLengths.fold(( v, sum ) -> sum + v, Int64.ofInt( 0 ));
	// trace( xPositions.map( v -> Std.string( v )) );
	// trace( yPositions.map( v -> Std.string( v )) );
	// trace( 'xBounds ${xBounds.min} ${xBounds.max}  median $median  centerLength $centerLength  totalCablesLength $totalCablesLength  total ${centerLength + totalCablesLength}' );

	return Std.string( centerLength + totalCablesLength );
}

function getBounds( values:Array<Int64> ) {
	
	var min = Int64.parseString( "9223372036854775807" );
	var max = Int64.parseString( "-9223372036854775808" );

	for( v in values ) {
		if( v < min ) min = v;
		if( v > max ) max = v;
	}
	return { min: min, max: max }
}

function getMedian( values:Array<Int64> ) {
	values.sort(( a, b ) -> a < b ? -1 : 1 );
	final length = values.length;
	final half = int( length / 2 );
	if( length % 2 == 1 ) return values[half];
	else {
		final v1 = values[half - 1];
		final v2 = values[half];
		// trace( 'half $half  v1 $v1  v2 $v2' );
		return ( v1 + v2 ) / 2;
	}
}

function abs( v:Int64 ) return v >= 0 ? v : -v;