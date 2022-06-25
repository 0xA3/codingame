import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
/*
Starting at coordinates (0,0) with D[0]=0, a random direction generator D[n+1] = (a*D[n]+b) mod m tells you which direction to go next (where D mod 4=0,1,2,3 indicates Up, Down, Left, Right). How many steps does it take to get back to (0,0)?
*/

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final m = parseInt( readline());
	
	var x = 0;
	var y = 0;
	
	var dn = 0;
	final rand = () -> {
		dn = ( a * dn + b ) % m;
		// printErr( 'dn $dn' );
		return dn;
	}

	var steps = 0;
	while( true ) {
		var dir = rand() % 4;
		// printErr( 'dir $dir' );
		x += dir == 2 ? -1 : dir == 3 ? 1 : 0;
		y += dir == 0 ? -1 : dir == 1 ? 1 : 0;
		// printErr( 'xy $x:$y' );
		steps++;
		if( x == 0 && y == 0 ) break;
	}

	print( steps );

}
