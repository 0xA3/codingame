import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final k = parseInt( readline());
	final constraints = [for( i in 0...k ) readline()];

	final result = process( n, constraints );
	print( result );
}

function process( n:Int, constraints:Array<String> ) {
	return "";
}
