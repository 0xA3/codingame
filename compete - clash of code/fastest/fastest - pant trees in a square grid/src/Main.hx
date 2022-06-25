import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
John's task is to plant as many trees as he can in a square grid
One tree takes up 2x2 spaces
*/

function main() {

	final n = parseInt( readline());
	
	final h = int( n / 2 );
	print( h * h );
}
