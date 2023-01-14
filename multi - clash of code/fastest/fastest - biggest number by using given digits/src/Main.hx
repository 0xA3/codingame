import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
The program:
Your program must output the biggest number that is writtable by using the given digits.

Input
9
1 2 3 4 5 6 7 8 9
*/

function main() {

	readline();
	final inputs = readline().split(" ").map( s -> parseInt( s ));

	inputs.sort(( a, b ) -> b - a );
	
	print( parseInt( inputs.join("")) );
}
