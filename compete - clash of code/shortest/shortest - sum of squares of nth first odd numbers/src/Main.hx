import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Given an integer N, you have to output the sum of the squares of the Nth first odd numbers

For example, if N is 5, the sum of the squares of the Nth first odd numbers is 1**2 + 3**2 + 5**2 + 7**2 + 9**2 = 165 so you have to output 165

Input
5

Output
165

*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		var sum = 0;
		var i = 1;
		while( i <= n * 2 ) {
			sum += i * i;
			i += 2;
		}
		
		print( sum );
	}
}
