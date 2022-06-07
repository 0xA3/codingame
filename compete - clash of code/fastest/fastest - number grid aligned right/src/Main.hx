import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using StringTools;

function main() {

	final r = parseInt( readline());
	final c = parseInt( readline());
	
	final max = string( r * c - 1 ).length;
	var i = 0;
	for( _ in 0...r ) {
		var line = [];
		for( _ in 0...c ) {
			final s = string( i );
			final spaces = max - s.length;
			line.push( " " + [for( _ in 0...spaces ) " "].join( "" ) + s );
			i++;
		}
		print( line.join( "" ));
	}
}
