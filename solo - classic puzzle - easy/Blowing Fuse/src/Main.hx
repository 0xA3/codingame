import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;

class Main {
	
	static inline var BYTESIZE = 8;

	static function main() {
		
		var inputs = readline().split(' ');
		final numberOfDevices = parseInt( inputs[0] );
		final numberOfClicks = parseInt( inputs[1] );
		final fuseCapacity = parseInt( inputs[2] );
		
		var inputs = readline().split(' ');
		final devices = [for( i in 0...numberOfDevices ) parseInt( inputs[i] )];

		var inputs = readline().split(' ');
		final clicks = [for( i in 0...numberOfClicks ) parseInt(inputs[i] )];

		final result = process( fuseCapacity, devices, clicks );
		print( result );
	}

	static function process( fuseCapacity:Int, devices:Array<Int>, clicks:Array<Int> ) {
		
		final deviceStati = devices.map( _ -> false );

		var max = 0;
		for( click in clicks ) {
			final id = click - 1;
			final device = devices[id];
			deviceStati[id] = !deviceStati[id];
			var current = 0;
			for( i in 0...devices.length ) {
				if( deviceStati[i] ) current += devices[i];
			}
			if( current > max ) max = current;
			// trace( current );
			if( current > fuseCapacity ) return "Fuse was blown.";
		}

		return 'Fuse was not blown.\nMaximal consumed current was $max A.';
	}

}
