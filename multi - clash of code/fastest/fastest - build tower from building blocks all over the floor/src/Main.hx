import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.StringUtils;

/*
It's play time, and you've accidentally scattered all of your favourite building blocks all over your bedroom floor! Bummer.

Each block is a cube with side length equal to S. All of the blocks have landed at their own unique position on your bedroom floor. Given an N * M map of your floor denoting the position of each block, can you determine the tallest tower you can build if you gather all of the blocks up and play with them?

Input
3 3
1
..o
...
.o.

Output
2
*/

function main() {

	final inputs = readline().split(' ');
	final n = parseInt( inputs[0] );
	final m = parseInt( inputs[1] );
	final s = parseInt( readline() );
	final rows = [for( _ in 0...n ) readline()];
	
	var sum = rows.fold(( row, sum ) -> sum + row.count( "o" ), 0 );

	print( sum * s );
}
