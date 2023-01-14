import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
Given a string containing only spaces, uppercase, and lowercase letters of the English alphabet, determine the minimum number of key strokes on a QWERTY keyboard required to type the string.

Input
Hello World

Output
13

Input
HELLO WORLD

Output
12

*/

function main() {

	final s = readline();

	var sum = 0;
	var shift = 0;
	for( i in 0...s.length ) {
		final char = s.charAt( i );
		if( char.isUppercase() && shift == 0 ) {
			sum += 2;
			shift = 1;
		} else if( char.isLowercase() ) {
			shift = 0;
			sum += 1;
		} else {
			sum += 1;
		}
	}

	print( sum );
}
