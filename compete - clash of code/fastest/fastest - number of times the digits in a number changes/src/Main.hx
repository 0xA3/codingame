import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Count the number of times the digits in a number changes. For example: 333 changes 0 times and 123 changes 2 times.

*/

function main() {

	final n = readline().split("");

	var changes = 0;
	for( i in 1...n.length ) if( n[i] != n[i-1]) changes++;
	print( changes );
}
