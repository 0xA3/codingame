import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final inputs = readline().split(' ');
		final cards = [for( i in 0...n ) parseInt( inputs[i] )];
		
		final result = process( cards );
		print( result );
	}

	static function process( cards:Array<Int> ) {

		var sum = 0;
		while( cards.length > 1 ) {
			cards.sort(( a, b ) -> a - b );
			final card = cards.shift() + cards.shift();
			cards.push( card );
			sum += card;
		}
		return sum;
	}

}
