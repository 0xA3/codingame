import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final grid = [for( i in 0...h ) readline().split(' ')];

	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	return "";
}
