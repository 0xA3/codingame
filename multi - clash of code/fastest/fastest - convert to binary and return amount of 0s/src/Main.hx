import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.NumberConvert;
using xa3.StringUtils;

/*
For numbers between N (inclusive) and M (inclusive), convert to binary and return the amount of 0's in those numbers.

Examples:
1: in the case of the number 0, the binary representation is 0, the number of zeroes is 1
2: in the case of the number 1, the binary representation is 1, the number of zeroes is 0
3: in the case of the range 1 to 2, the binary representation is (1, 10), the number of zeroes is 1

Input
0
0

Output
1
*/

function main() {

	final n = parseInt( readline());
	final m = parseInt( readline());
	
	var sum = 0;
	for( i in n...m + 1 ) sum += i.toBin().count( "0" );
	
	print( sum );
}
