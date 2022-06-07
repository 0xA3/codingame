import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	var n = parseInt( readline());
	var a = parseInt( readline());
	
	var count = 0;
	while( n > 1 ) {
		if( n % 2 == 0 && a > 0 ) {
			n = int( n / 2 );
			a--;
		} else {
			n = n - 1;
		}
		count++;
	}

	print( count );
}
