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
	
	final length = getLength( sensorDatasets );
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

function getLength( sensorDatasets:Array<Array<Int>> ) {
	var callibratorSpace = -1;
	
	for( i in 0...sensorDatasets.length ) if( sensorDatasets[i][0] == 0 ) { callibratorSpace = i; break; }
	for( i in callibratorSpace...sensorDatasets.length ) if( sensorDatasets[i][3] == 0 ) return i - callibratorSpace + 1;
	
	throw "Error: length not found";
}

