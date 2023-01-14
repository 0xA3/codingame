import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = readline();
	final a = [for( i in 0...n.length ) n.charAt( i )];
	a.reverse();
	
	final v1 = parseInt( n );
	final v2 = parseInt( a.join( "" ));
	
	print( v1 - v2 );
}
