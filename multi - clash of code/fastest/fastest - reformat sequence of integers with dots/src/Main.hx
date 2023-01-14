import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

/*
The goal is to reformat a sequence of integers, so that each pair is separated by a number of points ('.') equal to the number on the left.

Input
5
1 2 3 4 5
Output
1.2..3...4....5

*/
function main() {

	final lenT = parseInt( readline());
	final inputs = readline().split(" ").map( s -> parseInt( s ));

	var output = "";
	for( i in 0...inputs.length ) {
		final v = inputs[i];
		output += '$v';
		if( i < inputs.length - 1 ) output += ".".repeat( v );
	}
	print( output );
}
