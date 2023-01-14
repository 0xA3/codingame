import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var FIFTY = 50;
	

	static function main() {
		
		final n = parseInt( readline() );
		final horses:Array<Horse> = [for( i in 0...n ) {
			var inputs = readline().split(' ');
			{ velocity: parseInt(inputs[0]), elegance: parseInt(inputs[1]) }
		}];
				
		final result = process( horses );
		print( result );
	}

	static function process( horses:Array<Horse> ) {
		
		var d = 9999999.;
		for( h1 in 0...horses.length ) {
			for( h2 in 0...h1 ) {
				final horse1 = horses[h1];
				final horse2 = horses[h2];
				d = min( d, abs( horse2.velocity - horse1.velocity ) + abs( horse2.elegance - horse1.elegance ));
			}
		}
		return int( d );
	}

}

typedef Horse = {
	final velocity:Int;
	final elegance:Int;
}