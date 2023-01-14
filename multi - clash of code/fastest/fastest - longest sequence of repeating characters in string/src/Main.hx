import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
You are given a string of random characters. Some of the characters are repeating in a sequence. For example,
aabcddda
a repeats in a row 2 times.
d repeats in a row 3 times.

Find out the longest sequence of repeating characters. For the above example, the longest sequence is d, repeating 3 times.

If there are more than one longest repeating sequence, use the first longest repeating sequence as the answer.

Input
aabcddda

Output
d 3
*/

function main() {

	final s = readline();
	
	final parts = s.splitUpSameChars();
	parts.sort(( a, b ) -> b.length - a.length );
	print( '${parts[0].firstChar()} ${parts[0].length}' );

	// longer version
	/*

	var maxChar = "";
	var max = 0;
	
	var count = 1;
	var lastChar = s.charAt( 0 );
	for( i in 1...s.length ) {
		final char = s.charAt( i );
		if( char == lastChar ) {
			count++;
		} else {
			if( count > max  ) {
				max = count;
				maxChar = lastChar;
			}
			count = 1;
			lastChar = char;
		}
	}
	
	if( count > max  ) {
		max = count;
		maxChar = lastChar;
	}

	print( '$maxChar $max' );
	*/
}
