import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final line = readline();
	var output = "";

	var currentChar = line.charAt( 0 );
	for( i in 0...line.length ) {
		if( line.charAt( i ) != currentChar ) {
			output += " ";
			currentChar = line.charAt( i );
		}
		output += line.charAt( i );
		
	}
	
	print( output );
}
