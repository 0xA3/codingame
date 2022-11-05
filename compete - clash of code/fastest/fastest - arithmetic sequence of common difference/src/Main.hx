import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Your program must print the N first numbers of an arithmetic sequence of common difference R and started by 0.

An arithmetic sequence is a sequence of numbers such that the next term can be computed by adding a constant value R.

Input
5 2

Output
0 2 4 6 8

*/

function main() {

	final inputs = readline().split(" ");
	final n = parseInt( inputs[0] );
	final r = parseInt( inputs[1] );
	
	final outputs = [for( i in 0...n ) r * i];
	print( outputs.join(" ") );
}
