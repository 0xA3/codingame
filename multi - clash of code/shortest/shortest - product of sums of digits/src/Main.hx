import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
Given a string of space separated numbers, calculate the product of all the sums of the digits of each number.
e.g. given "3 32 12 50", the answer would be (3)*(3+2)*(1+2)*(5+0)=3*5*3*5=225, so you would output 225

Input
3 32 12 50

Output
225
*/

class Main {
	
	static function main() {
		
		final numbers = readline().split(" ");
		final sums = [];
		for( number in numbers ) {
			final digits = number.split( "" ).map( s -> parseInt( s ));
			var sum = 0;
			for( digit in digits ) sum += digit;
			sums.push( sum );
		}
		
		var product = 1;
		for( sum in sums ) product *= sum;

		print( product );
	}
}

