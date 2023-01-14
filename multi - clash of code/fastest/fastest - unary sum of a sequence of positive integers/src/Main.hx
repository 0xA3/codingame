import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.StringUtils;

/*
Write a simple calculator that operates in unary to sum a sequence of positive integers.

Unary is the bijective numeration base 1, using the digit 1 to represent 1 but lacking a zero digit. It is a positional numbering system, but trivially so, since every position, as a power of 1, is a ones place, regardless of left or right direction.

Starting from 1, the first five numbers in unary are 1, 11, 111, 1111, and 11111.

Input
5
1 11 111 1111 11111

Output
111111111111111

*/

function main() {

	final n = parseInt( readline());
	final sum = readline().split(" ").map( s -> s.length ).fold(( v, sum ) -> sum + v, 0 );
	print( "1".repeat( sum) );
}
