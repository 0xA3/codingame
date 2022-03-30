import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	
	var sumDiv3 = 0;
	var sumEven = 0;
	for( i in 0...n + 1 ) {
		if( i % 3 == 0 ) sumDiv3 += i;
		if( i % 2 == 0 ) sumEven += i;
	}

	print( ${sumDiv3 - sumEven} );
}
