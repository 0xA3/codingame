import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using StringTools;

var length:Int;

function main() {

	final alphabet = readline().split( "" );
	final message = readline();
	final word = readline();

	final result = process( alphabet, message, word );
	print( result );
}

function process( alphabet:Array<String>, message:String, word:String ) {

	length = alphabet.length;
	final reg = new EReg( word, "" );
	if( reg.match( message )) return message;
	
	final codes = [for( i in 0...message.length) message.charAt( i )];

	for( multiply in 1...length ) {
		for( shift in 1...length ) {
			final decoded =	codes.map( c -> alphabet[(( alphabet.indexOf( c ) + shift ) * multiply ) % length] ).join( "" );
			// trace( '$shift $decoded  match ${reg.match( decoded )}' );
			if( reg.match( decoded )) return decoded;
		}
	}
	
	throw 'Error: word not found';
}
