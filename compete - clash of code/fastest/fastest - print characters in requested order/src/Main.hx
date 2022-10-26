import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Read the characters from the standard input and print them in the requested order. The order is given as a series of digits describing the position in the original input string of the next character to print.

4
abcd
4 3 2 1

Output
dcba
*/

function main() {

	readline();
	final line = readline();
	final inputs = readline().split(" ").map( s -> parseInt( s ));
	
	final output = inputs.map( v -> line.charAt( v - 1 )).join("");
	
	print( output );
}
