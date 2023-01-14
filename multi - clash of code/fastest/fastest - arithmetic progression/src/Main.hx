import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final a = parseInt( readline());
	final d = parseInt( readline());
	final n = parseInt( readline());
	
	var result = a;
	for( _ in 1...n ) result += d;

	print( result );
}
