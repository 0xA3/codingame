import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
MEX stands for minimum excluded. Given a list of integers return the lowest non-negative integer that is not present in the list otherwise known as MEX of the list.

Input
5
1 2 3 0 5

Output
4
*/

function main() {

	final n = parseInt( readline());
	final inputs = readline().split(' ').map( s -> parseInt( s ));

	inputs.sort(( a, b ) -> a - b );
	printErr( inputs );
	
	for( i in 0...n + 1 ) {
		if( inputs[i] != i ) {
			print( i );
			break;
		}
	}
}
