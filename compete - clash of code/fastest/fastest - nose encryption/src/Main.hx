import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
A little while ago, my friend showed me a program that encoded a string into "NOSE" encryption. The program makes each letter in a string either the letter "N", "O", "S", or "E". The program decided what to replace each letter with like this:
Let's call the current letter's index in the alphabet "I" (a=1, b=2, c=3)
If "I" is divisible by 2, make the letter "N".
If "I" is divisible by 3 and not 2, make the letter "O".
If "I" is divisible by 5 and not 2 or 3, make the letter "S".
If "I" isn't divisible by 2, 3, or 5, make the letter "E".

Your Task:
Make a program that can encrypt a string into "NOSE" encryption.
You should encode spaces as spaces.

Note:
"NOSE" encryption is irreversible, so you won't be able to decrypt it.

Input
easy peasy

Output
SEES NSEES

*/

function main() {

	final s = readline().split( "" );
	final output = s.map( char -> {
		if( !char.isLetter() ) return char;
		final code = char.charCodeAt( 0 ) - "a".code + 1;
		if( code % 2 == 0 ) return "N";
		if( code % 3 == 0 ) return "O";
		if( code % 5 == 0 ) return "S";
		return "E";
	});
	
	print( output.join("") );
}
