import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
Almost all of the words contain vowels. The letters which are considered to be vowels (in English) are a,e,i,o,u.
Display the total number of vowels present at odd indexes in the given string.

Input
Hello World

Output
2

*/

function main() {

	final s = readline().split( "" );

	var sum = 0;
	for( i in 0...s.length ) if( i % 2 == 1 && s[i].isVowel() ) sum += 1;

	print( sum );
}
