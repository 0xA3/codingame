import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;

using Lambda;
using StringTools;

/*
The program:
The Syracuse (or Collatz) suite is defined as follows: given an initial integer greater than 0, we apply the following operations while the integer is different that 1:
- it is divided by 2 when even,
- it is multiplied by 3 and raised by 1 when odd.

Your program must display the Syracuse suite of the number N and stop when the value 1 is reached.
*/

function main() {

	final n = parseFloat( readline());
	
	final suite = [n];
	while( suite[suite.length - 1] != 1 ) {
		final o = suite[suite.length - 1];
		if( o % 2 == 0 ) suite.push( o / 2 );
		else  suite.push( o * 3 + 1 );
	}
	print( suite.join(" "));
}
