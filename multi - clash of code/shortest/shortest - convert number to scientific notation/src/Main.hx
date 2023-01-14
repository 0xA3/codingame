import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Convert every number given to scientific notation.

Khan Academy (slightly edited):
Scientific notation is a way of writing very large or very small numbers (for this clash only large numbers). In this case, a number is written in scientific notation when 10 is multiplied by a power from 1 to 10 .
For example, 650,000,000 can be written in scientific notation as 6.5 * 10^8.

There should only be one significant digit before the decimal place.

Input
132000

Output
1.32 * 10^5

*/
using StringTools;

class Main {
	
	static function main() {
		
		final n = readline();
		final exp = n.length - 1;
		var left = n.charAt( 0 );
		var right = n.substr( 1 ).replace( "0" , " " ).rtrim().replace( " ", "0" );
	
		final num = right.length > 0 ? '$left.$right' : left;
		print( '$num * 10^$exp' );
	}
}

