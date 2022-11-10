import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.MathUtils;
using xa3.StringUtils;

/*
You are given a single string. You need to convert each character into it's ASCII value and add the odd numbers together.

Example
Input: ABC
A,B,C → 65,66,67
Take odd numbers
65+67=132

*/

function main() {

	final n = readline().split("").map( s -> s.charCode() );

	var sum = 0;
	for( i in 0...n.length ) if( n[i].isOdd() ) sum += n[i];
	print( sum );
}
