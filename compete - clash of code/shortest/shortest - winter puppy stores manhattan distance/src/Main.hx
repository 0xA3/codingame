import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Math.abs;

/*
It's the middle of winter, and you've got the winter blues real bad. What you need is a puppy! And fast! There is no time to think through the extra responsibilities you're about to take on. Because all the roads in your town run north-south and east-west, you can calculate the distances between locations by adding together the difference in x coordinates and the difference in y coordinates (manhattan distance).

Given the location of your house and a list of pet store locations, which store is the nearest?

Input
10 10
1
12 11

Output
1 3
*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final hx = parseInt(inputs[0]);
		final hy = parseInt(inputs[1]);
		final n = parseInt(readline());
		final distances = [];
		for( _ in 0...n ) {
			var inputs = readline().split(' ');
			final px = parseInt(inputs[0]);
			final py = parseInt(inputs[1]);
			final distance = abs( px - hx ) + abs( py - hy );
			distances.push( distance );
		}

		printErr( distances );

		var index = 1;
		var distance = distances[0];
		for( i in 1...distances.length ) {
			if( distances[i] < distance ) {
				index = i + 1;
				distance = distances[i];
			}
		}

		print( '$index $distance' );
	}
}

