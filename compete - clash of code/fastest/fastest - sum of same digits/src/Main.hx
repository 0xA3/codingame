import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final l = parseInt( readline());
	final r = parseInt( readline());

	var sum = 0;
	for( i in l...r + 1 ) for( o in 1...10 ) sum += i;

	print( '$sum' );
}
