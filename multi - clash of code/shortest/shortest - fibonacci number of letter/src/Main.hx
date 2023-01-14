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
You are given a letter S (0=a, 1=b, 2=c, and so on). You need to find the corresponding Fibonacci number.
Fibonacci Sequence:-
1, 1, 2, 3, 5, 8, 13, 21...
with the first term being "a".

Input
a

Output
1

*/

class Main {
	
	static function main() {
		
		final t = readline().charCodeAt( 0 ) - "a".code + 1;
		
		print( MathUtils.fibonacci( t ));
	}
}
