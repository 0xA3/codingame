import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

/*
Given an integer N, you have to return the difference D between the
sum of the digits at even positions (first digit at position 0) and the
sum of the digits at odd positions.
*/

 function main() {

	final a = readline().split( "" );
	
	var sum = 0;
	for( i in 0...a.length ) sum = i % 2 == 0 ? sum + parseInt( a[i] ) : sum - parseInt( a[i] );
	
	print( sum );
}
