import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;

/*
Every number has a unique prime factorisation.

Example
12 = 2×2×3
2310 = 2×3×5×7×11

For a given input number, your program must output the sum of the numbers in the unique prime factorisation of that number.

*/

function main() {

	final n = parseInt( readline());
	
	print( MathUtils.primeFactors( n ).sum() );
}
