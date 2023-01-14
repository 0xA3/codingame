import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
Your program must find the missing digit in a single line of sudoku.
As a reminder, in a sudoku grid, each line must contain all digits from 1 to 9, one time each.

Input
8372?9514

Output
6

*/

function main() {

	final numbers = readline();

	for( i in 1...10 ) {
		if( !numbers.contains( '$i' )) {
			print( '$i' );
			return;
		}
	}
}
