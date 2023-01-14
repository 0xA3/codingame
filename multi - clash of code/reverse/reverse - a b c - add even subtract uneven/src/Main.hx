import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final c = parseInt( readline());
	
	final list = [a, b, c];
	var sum = 0;
	for( k in list ) {
		if( k % 2 == 0 ) sum += k;
		else sum -= k;
	}
	print( sum );
}
