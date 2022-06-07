import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	var sweets = 1;
	var sum = 0;
	for( _ in 0...n ) {
		sum += sweets;
		sweets += 2;
	}
	
	print( '${Math.ceil( sum / 10 )}' );
}
