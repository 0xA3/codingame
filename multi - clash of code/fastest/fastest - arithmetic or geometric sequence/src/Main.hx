import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Given the length N and the input sequence a, your program should find the next integer in the provided sequence.
The sequence  is always going to be either an arithmetic sequence (i.e. a[i+1] = a[i]+X, X is an integer) or a geometric sequence (i.e. a[i+1] = a[i]*R, R is an integer))

Input
5
1 3 5 7 9

Output
11
*/

function main() {

	final n = parseInt( readline());
	final inputs = readline().split(" ");
	final values = inputs.map( s -> parseInt( s ));
	
	var dSum = values[1] - values[0];
	if( values[2] == values[1] + dSum ) {
		print( values[values.length - 1] + dSum );
	} else {
		final dMult = values[1] / values[0];
		print( values[values.length - 1] * dMult );
	}
}
