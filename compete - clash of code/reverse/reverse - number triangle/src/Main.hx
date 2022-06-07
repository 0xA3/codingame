import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	for( i in 0...n ) print( [for( _ in 0...i + 1 ) n].join( "" ));
	
}
