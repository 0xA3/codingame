import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	var sumOdd = 0;
	var sumEven = 0;
	for( i in 1...n + 1 ) {
		if( i % 2 == 0 ) sumEven += i;
		else sumOdd += i;
	}
	print( '$sumOdd\n$sumEven' );
}
