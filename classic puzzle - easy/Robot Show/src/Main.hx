import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final length = parseInt( readline() );
		final n = parseInt( readline() );
		var inputs = readline().split(' ');
		final initLocations = [for( i in 0...n) parseInt( inputs[i] )];

		final result = process( length, initLocations );
		print( result );
	}

	static function process( length:Int, initLocations:Array<Int> ) {
		var max = 0;
		for( location in initLocations ) {
			max = int( Math.max( max, location ));
			max = int( Math.max( max, length - location ));
		}
		return max;
	}

}
