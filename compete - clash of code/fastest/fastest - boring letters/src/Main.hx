import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using StringTools;

function main() {

	var s = readline();
	
	final regex = ~/(.)\1+/g;
	for( _ in 0...999 ) s = regex.replace( s, '' );
   
	print( s );
}

