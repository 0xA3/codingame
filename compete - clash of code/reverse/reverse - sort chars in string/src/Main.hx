import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = readline().split( "" );
	n.sort(( a, b ) -> a.charCodeAt( 0 ) - b.charCodeAt( 0 ));
	
	print( n.join( "" ));
}
