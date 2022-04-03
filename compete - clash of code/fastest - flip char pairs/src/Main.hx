import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final t = readline();
	
	final pairs = int( t.length / 2 );
	
	var output = "";
	for( i in 0...pairs ) {
		final pos = i * 2;
		output += t.charAt( pos + 1 ) + t.charAt( pos );
	}
	if( t.length % 2 == 1 ) output += t.charAt( t.length - 1 );

	print( '$output' );
}
