import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final m = parseInt( readline());
	final n = parseInt( readline());
	
	print(( m - 1 + n ) % 7 + 1 );
}
