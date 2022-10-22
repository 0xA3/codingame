import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

/*
Squares are indeed beautiful. But they are even more beautiful when they are nested inside each others... You are given a number N, the side's length of the biggest square. Then you must display wonderful squares like this:

(N=7)
#######
#ooooo#
#o###o#
#o#o#o#
#o###o#
#ooooo#
#######

...nice, isn't it?

Input
5

Output
#####
#ooo#
#o#o#
#ooo#
#####

*/

function main() {

	final n = parseInt( readline());
	
	for( y in 0...n ) {
		final line = [for( x in 0...n ) {
			final dTop = y;
			final dLeft = x;
			final dBottom = n - y - 1;
			final dRight = n - x - 1;
			final min = min( dTop,  min( dLeft, min( dBottom, dRight )));
			// printErr( '$x:$y  dTop $dTop  dLeft $dLeft  dBottom $dBottom  dRight $dRight   $min' );
			min % 2 == 0 ? "#" : "o";
		}].join( "" );
		print( line );
	}
}
