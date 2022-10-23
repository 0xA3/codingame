import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;

/*
You are given a string of characters s. Output the sum of the ASCII value for each character of the string.

*/

function main() {

	final n = readline().split("").map( s -> s.charCodeAt( 0 )).fold(( v, sum ) -> sum + v, 0 );
	
	print( n );
}
