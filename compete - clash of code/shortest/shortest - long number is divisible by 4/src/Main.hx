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
Print "Ok" if the super-long integer N is not divisible by four.
Print "AAAAAAAAAA!!!" otherwise.

Input
1

Output
Ok
*/

class Main {
	
	static function main() {
		
		final n = readline();
		final lastDigits = parseInt( n.substr( n.length - 2 ));
	
		print( lastDigits % 4 == 0 ? "AAAAAAAAAA!!!" : "Ok" );
	}
}
