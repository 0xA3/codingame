import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
You must invert the case of each letter of the alphabet and remove special characters (except spaces and digits) contained in the given string S.
E.g. : Hello World! becomes hELLO wORLD

Input
Hello World !

Output
hELLO wORLD
*/

function main() {

	final n = readline().split( "" );

	final outputs = [];
	for( char in n ) {
		if( char.isLowercase()) outputs.push( char.toUpperCase());
		else if( char.isUppercase()) outputs.push( char.toLowerCase());
		else if( char.isNumber() || char == " ") outputs.push( char );
	}
	
	print( outputs.join("") );
}
