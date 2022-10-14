import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final encryptedMessage = readline();
	
	final message = [for( i in 0...int( encryptedMessage.length / 2 )) encryptedMessage.substr( i * 2, 2 )]
	.map( s -> parseInt( s )).map( v -> String.fromCharCode( v )).join( "" );
	print( message );
}
