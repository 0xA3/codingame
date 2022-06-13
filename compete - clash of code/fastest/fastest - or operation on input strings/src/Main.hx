import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final n1 = inputs[0].split( '' );
	final n2 = inputs[1].split( '' );

	var output = "";
	for( i in 0...n1.length ) {
		output += n1[i] == "1" || n2[i] == "1" ? "1" : "0";
	}
	print( output );
}
