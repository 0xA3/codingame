import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using xa3.StringUtils;

/*
A normal sentence is clear, but Am A Ammmmmmmmmm stuttering Ammmmmmmm sentence Amm is Ammmm like Ammmm that !

To form a stuttering sentence, each word is preceded by A plus a number of m's equal to the length of the word plus a space character. Digits and punctuation marks have no effect. This means that, for every word, the length does not take into account the non-alphabetic characters (0 to 9, ? \ / - + * ; [ ] ).

If a "word" consists of non-alphabetic characters only (e.g. "3579"), the "word" is output without any modification.

Input
Hello

Output
Ammmmm Hello
*/

function main() {

	final cleartext = readline();
	final words = cleartext.split(" ");

	var outputs = [];
	for( word in words ) {
		final letters = word.split("").filter( s -> s.isLetter()).length;
		if( letters == 0 ) outputs.push( word );
		else outputs.push( "A" + "m".repeat( letters ) + ' $word' );
	}

	print( outputs.join(" ") );
}
