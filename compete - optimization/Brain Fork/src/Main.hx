import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;

inline var NUM_ZONES = 30;
inline var ALPHABET = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";

var charMap:Map<String, Int>;

function main() {

	final magicPhrase = readline();
	printErr( magicPhrase );
	
	final result = process( magicPhrase );
	print( result );
}

function process( magicPhrase:String ) {
	
	charMap = [for( i in 0...ALPHABET.length ) ALPHABET.charAt( i ) => i ];
	final charCodes = magicPhrase.split( "" ).map( char -> charMap[char]);
	trace( charCodes );

	final position = 0;
	final zones = [for( _ in 0...NUM_ZONES ) new Zone( ALPHABET.length )];

	for( c in charCodes ) trace( zones[0].getDistance( c ));


	return '+.>-.';
}
