import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Help Jack Goff find a seat in classroom which is at equal distance from his friend Bob and crush Erica such that he's as near to them as possible.
It is guaranteed that a seat always exist in middle of Bob and Erica, as they are either sitting in the same row or same column or sitting diagonally to each other.

Input
1 3
3 1

Output
2 2
*/

function main() {

	final b = readline().split(" ").map( s -> parseInt( s ));
	final e = readline().split(" ").map( s -> parseInt( s ));
	
	final x = Math.abs(( b[0] + e[0] ) / 2 );
	final y = Math.abs(( b[1] + e[1] ) / 2 );

	print( '$x $y' );
}
