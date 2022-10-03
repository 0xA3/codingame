import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
The program:
Your program must print N times a given word, on separate lines.

*/

function main() {

	final n = parseInt( readline());
	final w = readline();
	
	final words = [for( _ in 0...n ) w];

	print( words.join( "\n" ));
}
