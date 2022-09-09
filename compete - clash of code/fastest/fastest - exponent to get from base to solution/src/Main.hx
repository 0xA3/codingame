import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils.log;

/*
ou are given a base, N, and a solution, Y. You must find the exponent needed to get from the base to the solution (such that N ^ X = Y) and print it.

Input
2
4

Output
2

*/

function main() {

	final n = parseInt( readline());
	final y = parseInt( readline());
	
	print( int( log( y, n )));
}
