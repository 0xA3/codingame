import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
You will receive an ASCII art input, which you must rotate by 90 degrees clockwise.
The individual characters, however, do not rotate ('|' does NOT become '-', for instance).

For example:
0===0

|...|

0---0

must be rotated to:
0|0

-.=

-.=

-.=

0|0

5 3
.---.
|---|
.---.

Output
.|.
---
---
---
.|.
*/

function main() {

	final inputs = readline().split(" ");
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final grid = [for( _ in 0...h ) readline().split( "" )];
	
	for( x in 0...w ) {
		var col = [];
		for( y in -h + 1...1 ) col.push( grid[-y][x] );
		print( col.join( "" ));
	}
}
