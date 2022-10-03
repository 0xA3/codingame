import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
From the given list of numbers find out which number is repeated an odd number of times
if there is no number repeating odd times, print 0

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		final numbers = readline().split(" ").map( s -> parseInt( s ));

		numbers.sort(( a, b ) -> a - b );
		printErr( numbers );

		var r = 0;
		var num = numbers[0];
		for( i in 1...numbers.length ) {
			// printErr( 'numbers[$i]: ${numbers[i]}  num $num  r $r' );
			r++;
			if( numbers[i] != num || i == numbers.length - 1 ) {
				if( r % 2 == 1 ) {
					print( num );
					return;
				}
				num = numbers[i];
				r = 1;
			}
		}

		print( 0 );
	}
}

