import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.NumberFormat;

/*
You must compute the area of trapezoid

Input
1
2
3

Output
4.5
*/

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final h = parseInt( readline());

	final area = ( a + b ) / 2 * h;

	print( area.fixed( 1 ));
}
