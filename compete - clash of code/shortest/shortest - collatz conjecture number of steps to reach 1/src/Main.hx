import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
The Collatz conjecture is a opened mathematics problem: given a number N, the repetition of the following operation will always eventually reach the loop 1 ⇒ 4 ⇒2 ⇒1 ...
* If N is even, N becomes N/2
* If N is odd, N becomes 3*N+1

Can you try it with the given numbers and print the number of steps it took to reach 1?

*/

class Main {
	
	static function main() {
		
		var n = parseFloat( readline());
		
		var steps = 0;
		while( n != 1 ) {
			n = n % 2 == 0 ? n / 2 : 3 * n + 1;
			steps++;
		}
		print( steps );
	}
}
