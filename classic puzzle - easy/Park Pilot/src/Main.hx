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
	final leftSpaceCounts = [0];
	final rightSpaceCounts = [0];
	for( i in 1...sensorDatasets.length ) {
		final dataset = sensorDatasets[i];
		leftSpaceCounts[i] = dataset[0] == 0 ? leftSpaceCounts[i - 1] + 1 : 0;
		rightSpaceCounts[i] = dataset[1] == 0 ? rightSpaceCounts[i - 1] + 1 : 0;
	}

	var parkingSpaces = [];
	for( i in 1...sensorDatasets.length ) {
		if( leftSpaceCounts[i] >= length ) parkingSpaces.push( '${i - 1 + length}L' );
		if( rightSpaceCounts[i] >= length ) parkingSpaces.push( '${i - 1 + length}R' );
	}
	return '$length\n' + parkingSpaces.join( "\n" );
}

function getLength( sensorDatasets:Array<Array<Int>> ) {
	var space = -1;
	
	for( i in 0...sensorDatasets.length ) if( sensorDatasets[i][0] == 0 ) { space = i; break; }
	for( i in space...sensorDatasets.length ) if( sensorDatasets[i][3] == 0 ) return i - space + 1;
	
	throw "Error: length not found";
}

