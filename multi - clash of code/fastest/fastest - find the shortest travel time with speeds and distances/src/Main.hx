import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.ArrayUtils;

/*
You have a list of speeds and distances as input and you must find the shortest travel time.

Input
2
103 26
162 54

Output
15
*/

function main() {

	final n = parseInt( readline());
	final times = [for( _ in 0...n ) {
		final inputs = readline().split(" ").map( s -> parseInt( s ));
		inputs[1] / inputs[0];
	}];
	
	times.fsort();

	print( Math.round( times[0] * 60 ));
}
