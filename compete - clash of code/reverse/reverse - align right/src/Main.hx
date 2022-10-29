import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;

function main() {

	final n = parseInt( readline());
	final inputs = [for( i in 0...n )  readline()];

	print( inputs.alignRight().join( "\n" ));
}
