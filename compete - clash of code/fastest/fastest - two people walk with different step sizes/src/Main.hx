import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;


/*
Two people walk along the same road, but with different step sizes. Find the difference in the number of steps it takes them to walk the same distance.

The number of feet in a mile is 5280.

Input
1
2
1

Output
2640

*/

function main() {

	final n = parseInt( readline());
	final m = parseInt( readline());
	final d = parseInt( readline());
	
	final feet = d * 5280;

	final stepsPerson1 = feet / n;
	final stepsPerson2 = feet / m;

	print( Math.round( Math.abs( stepsPerson1 - stepsPerson2 ) ));
}
