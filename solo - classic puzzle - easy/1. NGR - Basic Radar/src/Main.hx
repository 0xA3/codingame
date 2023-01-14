import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final snapshots = [for( i in 0...n ) {
		final inputs = readline().split(" ");
		final snapshot:Snapshot = {
			plate: inputs[0],
			radarname: inputs[1],
			timestamp: parseFloat( inputs[2] )
		}
		snapshot;
	}];
		
	final result = process( snapshots );
	print( result );
}

function process( snapshots:Array<Snapshot> ) {
	
	final cars:Map<String, Array<Float>> = [];
	for( snapshot in snapshots ) {
		if( cars.exists( snapshot.plate )) cars[snapshot.plate].push( snapshot.timestamp );
		else cars.set( snapshot.plate, [snapshot.timestamp] );
	}

	final carsToReport = [];
	for( plate => timestamps in cars ) {
		final speed = Std.int( 13 / ( abs( timestamps[1] - timestamps[0] ) / 3600000 ));
		if( speed > 130 ) carsToReport.push( '$plate $speed' );
	}
	carsToReport.sort(( a, b ) -> a < b ? -1 : 1 );
	
	return carsToReport.join( "\n" );
}

typedef Snapshot = {
	final plate:String;
	final radarname:String;
	final timestamp:Float;
}
