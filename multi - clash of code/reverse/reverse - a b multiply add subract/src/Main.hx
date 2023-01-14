import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	print( '${a * b}${a + b}${a - b}' );
}

