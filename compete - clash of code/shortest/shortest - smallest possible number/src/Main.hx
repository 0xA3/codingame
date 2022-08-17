import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final inputs = readline().split(" ").map( s -> parseInt( s ));
		print( process( inputs ));
	}

	static function process( inputs:Array<Int> ) {
		inputs.sort(( a, b ) -> a - b );
		
		for( i in 0...inputs.length ) {
			if( inputs[i] != 0 ) {
				return [inputs[i]].concat( inputs.slice( 0, i )).concat( inputs.slice( i + 1, inputs.length )).join( "" );
			}
		}
		return "";
	}
}

