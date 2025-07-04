import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;


function main() {
	final inputs = readline().split(' ');
	final h = parseInt(inputs[0]);
	final w = parseInt(inputs[1]);
	final rows = [for ( i in 0...h ) readline()];

	final result = process( rows );
	print( result );
}

function process( rows:Array<String> ) {
	
	return "";
}
