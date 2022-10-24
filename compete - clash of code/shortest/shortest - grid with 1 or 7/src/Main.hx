import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
John loves to play with grid games. We have to help him. He is playing with a
N by N square grid contain numbers.
Each cell in the grid either 1 or 7. There are exactly C cells which contains 1.
Find the sum of all numbers that are not 1

Input
4
3
1 7 1
1 1 7
7 7 7

Output
35

*/

class Main {
	
	static function main() {
		
		final c = parseInt(readline());
		final n = parseInt(readline());
		for( _ in 0...n ) readline();

		print(( n * n - c ) * 7);
	}
}

