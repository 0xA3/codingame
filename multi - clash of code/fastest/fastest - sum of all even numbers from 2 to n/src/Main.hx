import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

/*
Given a number N sum up all even numbers from 2 to N.

Input
10

Output
30
*/

function main() {

	final n = parseInt( readline());
	final sum = [for( i in 2...n + 1 ) if( i % 2 == 0 ) i].fold(( v, sum ) -> sum + v, 0 );

	print( sum );
}
