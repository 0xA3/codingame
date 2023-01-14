import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.parseInt;
import haxe.xml.Printer;

using Lambda;
using StringTools;

function main() {

	final input = readline();
	
	// loop solution
	/*
	var letters = 0;
	var digits = 0;
	for( i in 0...input.length ) {
		final code = input.charCodeAt( i );
		if( code >= 48 && code <= 57 ) {
			digits++;
		} else if(( code >= 65 && code <= 90 ) || ( code >= 97 && code <= 122 )) {
			letters++;
		}
	}
	*/

	// regex solution
	final letters = ~/[^a-z]/ig.replace( input, "" ).length;
	final digits = ~/[^0-9]/ig.replace( input, "" ).length;
	
	print( '${round( letters / digits )}' );
}
