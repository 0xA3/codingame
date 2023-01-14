import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var FIFTY = 50;
	

	static function main() {
		
		final score = parseInt( readline() );
		
		final result = process( score );
		print( result );
	}

	static function process( score:Int ) {
		
		final combinations:Array<String> = [];
		for( tr in 0...int( score / 5 ) + 1 ) {
			for( transformation in 0...tr + 1 ) {
				for( penalty in 0...int( score / 3 ) + 1 ) {
					final tempScore = tr * 5 + transformation * 2 + penalty * 3;
					if( tempScore == score ) combinations.push( '$tr $transformation $penalty' );
				}
			}
		}
		return combinations.join( "\n" );
	}

}
