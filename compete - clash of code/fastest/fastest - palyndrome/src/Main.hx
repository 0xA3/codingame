import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

/*
A palindrome is a piece of text where the order of the letters stay the same whether you read from left to right or right to left.

Your program must output whether, for each word given on the standard input, where it is a palindrome or not.

A single letter is considered to be a palindrome.

*/

function main() {

	final n = parseInt( readline());
	final words = [for( _ in 0...n ) readline()];

	for( word in words ) {
		var isPalyndrome = true;
		for( i in 0...word.length ) {
			if( word.charAt( i ) != word.charAt( word.length - 1 - i )) {
				isPalyndrome = false;
				break;
			}
		}
		print( isPalyndrome ? "true" : "false" );
	}
}
