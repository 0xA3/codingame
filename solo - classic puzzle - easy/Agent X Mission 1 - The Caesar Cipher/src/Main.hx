import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;

using StringTools;

inline var RANGE_MIN = 32;
inline var RANGE_MAX = 126;
inline var RANGE_DELTA = RANGE_MAX - RANGE_MIN + 1;

function main() {

	final ciphertext = readline();
	final word = readline();

	final result = process( ciphertext, word );
	print( result );
}

function process( ciphertext:String, word:String ) {

	for( i in 0...RANGE_DELTA ) {
		final decoded = caesarShift( ciphertext, -i );
		final decodedCleaned = decoded.replace( ",", " " ).replace( ".", " " ).replace( "?", " " ).replace( ":", " " ).replace( "!", " " );
		final decodedWords = decodedCleaned.split( " " );
		// trace( '$i  $decoded' );

		for( decodedWord in decodedWords ) if( decodedWord == word ) {
			return '$i\n$decoded';
		}
	}

	return "";
}

function caesarShift( s:String, v:Int ) {
	final buf = new StringBuf();
	for( i in 0...s.length ) {
		final code = s.charCodeAt( i );
		final code2 = ( code - RANGE_MIN + v + RANGE_DELTA ) % RANGE_DELTA + RANGE_MIN;
		buf.add( String.fromCharCode( code2 ));
	}
	return buf.toString();
}
