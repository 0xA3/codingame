import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	if( n == 1 ) {
		print( "0" );
		return;
	}
	var a = [0, 1];
	while( a.length < n ) a.push( a[a.length - 1] + a[a.length - 2] );
	
	print( a.join(" "));
}
