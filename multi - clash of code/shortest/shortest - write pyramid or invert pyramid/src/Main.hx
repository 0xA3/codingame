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
- If the nb is odd, you write a pyramid.
- If the nb is even, you add one to the number and you write a invert pyramid.
- You fill the pyramid with the symbol on the second line (s1).
- The space where you don't write the symbol must be filled by the symbol on the third line (s2.


Input
5
*
 

Output
  *  
 *** 
*****
*/

class Main {
	
	static function main() {
		
		final nb = parseInt( readline());
		final s1 = readline();
		final s2 = readline();

		var width = nb % 2 == 0 ? nb + 1 : nb;
		var space = 0;
		final lines = [];
		while( width > 0 ) {
			final spaces = [for( _ in 0...space ) s2 ].join( "" );
			final pyramid = [for( _ in 0...width ) s1 ].join( "" );
			lines.push( spaces + pyramid + spaces );
			space++;
			width -= 2;
		}
		if( nb % 2 == 1 ) lines.reverse();
		print( lines.join( "\n" ));
	}
}

