import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

/*
Given an odd integer n that is not a multiple of 5, find the smallest multiple of n that only consists of 1s. You will always find one. Once found, output the number of 1s in the found number.

For instance, let n = 37. The multiples of 37 are 37, 74, 111,... so the least one that consists only of 1s is 111, which has 3 digits, then the answer is 3.

Input
3

Output
3
*/

function main() {

	final n = parseInt( readline());
	
	for( ones in 1...1000 ) {
		if( BigInt.fromString( "1".repeat( ones )) % n == 0 ) {
			print( ones );
			return;
		}
	}
}
