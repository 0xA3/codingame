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
The program:
Your program must write the number of minutes or the duration formatted as hh:mm.

*/

class Main {
	
	static function main() {
		
		final duration = readline();
		final h = parseInt( duration.substr( 0, 2 ));
		final m = parseInt( duration.substr( 3, 2 ));
	
		print( h * 60 + m );
	}
}

