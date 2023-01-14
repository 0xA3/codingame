import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

/*
Given a Morse message msg and a conversion table, display the corresponding message in natural language. If the Morse code doesn't exist in the conversion table, display it as "[]". A slash character "/" means space

Input
-.-. --- -.. .. -. --. .- -- .
10
A .-
C -.-.
G --.
D -..
E .
I ..
M --
N -.
O ---
S ...

Output
CODINGAME
*/

function main() {

	final msg = readline().split(" ");
	final n = parseInt( readline());
	final l = [];
	final c = [];
	for( _ in 0...n ) {
		final inputs = readline().split(' ');
		l.push( inputs[0] );
		c.push( inputs[1] );
	};

	// printErr( l.join(", ") );
	// printErr( c.join(", "));

	final outputs = [];
	for( code in msg ) {
		if( code == "/" ) outputs.push(" ");
		else if( !c.contains( code )) outputs.push( "[]" );
		else {
			outputs.push( l[c.indexOf( code )] );
		}
	}

	print( outputs.join( "" ));
}
