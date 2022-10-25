import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
Bob encrypted the message for Alice. Help Alice decrypt the message from Bob.

Input
eaSy valIdatoR, sir

Output
sir
*/

function main() {

	final message = readline().split( "" );
	final outputs = message.filter( s -> s.isUppercase() ).map( s-> s.toLowerCase() );
	
	print( outputs.join("") );
}
