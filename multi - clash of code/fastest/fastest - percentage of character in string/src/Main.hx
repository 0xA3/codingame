import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.StringUtils;

/*
You must find the percentage (rounded up) that given characters make up in a given string (without taking into account the case).

Input
Bonjour
1
j

Output
15%

*/

function main() {

	final s = readline().toLowerCase();
	final n = parseInt( readline());
	final chars = [for( _ in 0...n ) readline().toLowerCase()];

	for( char in chars ) {
		if( s.length > 0 ) print( Math.ceil( s.count( char ) / s.length * 100 ) + "%");
		else print( '0%' );
	}
	
}
