import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
You are given a number n. The number n can be negative or positive. If n is negative, print numbers from n to 0 by adding 1 to n. If positive, print numbers from n-1 to 0 by subtracting 1 from n.

Input
5

Output
4 3 2 1 0
*/

function main() {

	final n = parseInt( readline());

	final output = n == 0
	? "Already Zero"
	: n < 0
		? [for( i in n...1 ) i].join(" ")
		: [for( i in -n + 1...1 ) -i].join(" ");
	
	print( output );
}
