import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.StringUtils;

/*
Identify if sets of words are anagrams of one another. Anagrams are words spelled with the same quantity and choice of letters, like "oafs" and "sofa."

Input
2
dog god
mouse assume

Output
true
false
*/

function main() {

	final n = parseInt( readline());
	final wordPairs = [for( i in 0...n ) readline().split(' ')];
	
	for( wordPair in wordPairs ) print( '${checkForAnagram( wordPair )}' );
}

function checkForAnagram( wordPair:Array<String> ) {
	if( wordPair[0].length != wordPair[1].length ) return false;

	final chars0 = wordPair[0].toLowerCase().split( "" );
	final chars1 = wordPair[1].toLowerCase().split( "" );

	for( char in chars0 ) {
		final index = chars1.indexOf( char );
		if( index == -1 ) return false;
		chars1.remove( char );
	}

	return true;
}
