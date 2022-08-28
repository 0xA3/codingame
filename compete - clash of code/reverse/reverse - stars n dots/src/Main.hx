import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	
	final rows = [];
	for( i in 0...n + 1 ) {
		final stars = [for( _ in 0...i ) "*"];
		final dots = [for( _ in i...n) "."];
		rows.push( stars.concat( dots ).join( "" ));
	}
	print( rows.join( "\n" ));
}
