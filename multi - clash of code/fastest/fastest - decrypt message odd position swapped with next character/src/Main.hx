import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
You received a message encrypted in simple way: every character from the odd position is swapped with the next character. If message has odd length, the last character is moved to the beginning of the text.
Write a program to decrypt such encrypted messages.

Input
ehTsii  s aemssga

Output
This is a message

*/

function main() {

	var m = readline();

	print( process( m ));
	
}

function process( m:String ) {
	
	var lastChar = "";
	if( m.length % 2 == 1 ) {
		lastChar = m.charAt( 0 );
		m = m.substr( 1 );
	}

	var output = "";
	
	var i = 0;
	while( i < m.length - 1 ) {
		output += m.charAt( i + 1 ) + m.charAt( i );
		i += 2;
	}
	return output + lastChar;
}

function encrypt( m:String ) {

	var output = "";

	var i = 0;
	while( i < m.length - 1 ) {
		output += m.charAt( i + 1 ) + m.charAt( i );
		i += 2;
	}

	if( m.length % 2 == 1 ) output = m.charAt( m.length - 1 ) + output;

	return output;
}