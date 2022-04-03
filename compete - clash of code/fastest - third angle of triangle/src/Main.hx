import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(" ").map( s -> parseInt( s ));
	
	print( 180 - inputs[0] - inputs[1] );
}
