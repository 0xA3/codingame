import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
The program:
Given two angles of a triangle, calculate the third angle.

*/

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );

	print( 180 - a - b );
	
}
