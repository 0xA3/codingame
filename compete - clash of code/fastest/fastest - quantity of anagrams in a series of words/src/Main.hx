import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;
using xa3.ArrayUtils;
using xa3.StringUtils;

/*
The goal is to indicate the quantity of anagrams present in the series of words.
Case and spaces should be ignored.

Input
2
arc
car

Output
2

*/

function main() {

	final n = parseInt( readline());
	final words = [for( _ in 0...n ) readline().toLowerCase().replace( " ", "" )];
	
	final words2 = words.map( word -> word.sort() );
	printErr( words2 );

	var max = 0;
	for( word in words2 ) {
		final sum = words2.count( word );
		if( sum > 1 && sum > max ) max = sum;
	}
	
	print( max );
}
