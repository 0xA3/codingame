import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
print the sum of a range of natural numbers between a and b inclusive

Input
5
6

Output
11

*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(" ");
		var sum = 0;
		for( i in parseInt( inputs[0] )...parseInt( inputs[1] ) + 1 ) {
			sum += i;
		}
	
		print( sum );
	}
}

