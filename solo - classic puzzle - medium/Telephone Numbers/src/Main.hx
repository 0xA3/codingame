import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final telephoneNumbers = [for( _ in 0...n ) readline()];
	
	final result = process( telephoneNumbers );
	print( result );
}

function process( telephoneNumbers:Array<String> ) {
	final trie = new Trie();

	for( number in telephoneNumbers ) {
		final digits = number.split( "" ).map( s -> s.charCodeAt( 0 ) - "0".code );
		trie.insert( digits );
	}

	return trie.count;
}
