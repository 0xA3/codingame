import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Create your own string-splitting function which includes the separator on both sides of each split. For example, splitting the string "Hello World!" with the separator "o", would result in the array ["Hello", "o Wo", "orld!"].

Input
What a very short string.
a

Output
Wha
at a
a very short string.
*/

function main() {

	final s = readline();
	final r = readline();
	
	final splitted = s.split( r );
	final output = splitted.join( '$r\n$r' );

	print(output );
}
