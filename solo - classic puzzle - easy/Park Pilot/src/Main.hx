import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline() );
	final sensorDatasets = [for( i in 0...n ) readline().split("").map( s -> parseInt( s ))];
	
	final result = process( n, sensorDatasets );
	print( result );
}

function process( n:Int, sensorDatasets:Array<Array<Int>> ) {
	
	final front0 = sensorDatasets.map( a -> a[0] ).indexOf( 0 );
	final back0 = sensorDatasets.map( a -> a[3] ).indexOf( 0 );
	final length = back0 - front0 + 1;
	
	var leftSpace = 0;
	var rightSpace = 0;
	var parkingSpaces = [];
	for( i in 1...sensorDatasets.length ) {
		leftSpace = sensorDatasets[i][0] == 0 ? leftSpace + 1 : 0;
		rightSpace = sensorDatasets[i][1] == 0 ? rightSpace + 1 : 0;
		if( leftSpace >= length ) parkingSpaces.push( '${i - 1 + length}L' );
		if( rightSpace >= length ) parkingSpaces.push( '${i - 1 + length}R' );
	}
	return '$length\n' + parkingSpaces.join( "\n" );
}
