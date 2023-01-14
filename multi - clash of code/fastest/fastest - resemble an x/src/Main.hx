import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Determine how much a given input character resembles an X.
A character is given in a 5x5 matrix of '.' or '#'.

The X character is:

#...#
.#.#.
..#..
.#.#.
#...#


You need to output how many characters are different from the X provided above.
*/

final x = [
"#...#",
".#.#.",
"..#..",
".#.#.",
"#...#"
];

function main() {

	final rows = [for( _ in 0...5 ) readline()];
	
	var differentChars = 0;
	for( y in 0...rows.length ) {
		for( i in 0...rows.length ) if( rows[y].charAt( i ) != x[y].charAt( i )) differentChars++;
	}
	print( differentChars );
}
