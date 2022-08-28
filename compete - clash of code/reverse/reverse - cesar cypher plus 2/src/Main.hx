import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final message = readline();
	var output = "";
	for( i in 0...message.length ) {
		var charCode = message.charCodeAt( i );
		if( charCode < 65 ) output += message.charAt( i );
		else if( charCode <= 90 ) output += String.fromCharCode(( charCode - 65 + 2 ) % 26 + 65 );
		else if( charCode < 97 ) output += message.charAt( i );
		else if( charCode <= 122 ) output += String.fromCharCode(( charCode - 97 + 2 ) % 26 + 97 );
	}
	
	print( output );
}
