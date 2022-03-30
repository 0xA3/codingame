import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final s = readline();
	
	var lowestChar = "";
	for( i in 0...s.length ) {
		if( s.charAt( i ) != " " && s.charCodeAt( i ) < lowestChar.charCodeAt( 0 )) {
			lowestChar = s.charAt( i );
		}
	}

	print( s.replace( lowestChar, "" ));
}
