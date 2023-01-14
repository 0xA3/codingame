import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	
	print( Math.floor( n * 1.5 ) );
}
