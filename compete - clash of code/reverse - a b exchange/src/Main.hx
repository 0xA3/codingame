import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final a = readline();
	final b = readline();
	final input = readline();
	
	var o = "";
	for( i in 0...input.length ) {
		final char = input.charAt( i );
		if( char == a ) o += b;
		else if( char == b ) o += a;
		else o += char;
	}

	print( o );
}
