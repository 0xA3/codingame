import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberConvert;

/*
You will be given N binary numbers.
Print the decimal sum of the odd numbers.

Input
1
111

Output
7

*/

function main() {

	final n = parseInt( readline());
	var sum = 0;
	for( i in 0...n ) {
		// final number = readline().fromBin();
		final number = parseInt( readline()); // manually modify
		if( number % 2 == 1 ) sum += number;
	}
	
	print( sum );
}
