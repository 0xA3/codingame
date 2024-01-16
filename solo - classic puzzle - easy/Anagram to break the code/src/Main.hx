import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.string;

using Lambda;

function main() {
	final w = readline();
	final s = readline();
	
	final result = process( w, s );
	print( result );
}

function process( inputWord:String, sentence:String ) {
	final sEreg = ~/[:\.,\?! ]+/g;
	final fEreg = ~/[a-zA-Z_0-9]/g;
	// final words = sEreg.split( sentence ).filter( word -> fEreg.match( word ));
	final words = sEreg.split( sentence ).filter( word -> word != "" );

	// trace( 'inputWord $inputWord' );
	// trace( 'words $words' );
	var keyPosition = -1;
	for( i in 0...words.length ) {
		// trace( '$i ${words[i]}' );
		if( checkForAnagram( inputWord, words[i] )) {
			keyPosition = i;
			// trace( 'found anagram at $i  $inputWord ${words[i]}' );
			break;
		}
	}

	if( keyPosition == -1 ) return "IMPOSSIBLE";

	final d1 = lastDigit( keyPosition );
	final d2 = lastDigit( words.length - keyPosition - 1 );
	final d3 = lastDigit( [for( i in 0...keyPosition ) words[i].length].fold(( v, sum ) -> sum + v, 0 ));
	final d4 = lastDigit( [for( i in keyPosition + 1...words.length) words[i].length].fold(( v, sum ) -> sum + v, 0 ));
	
	return '$d1.$d2.$d3.$d4';
}

function checkForAnagram( word1:String, word2:String ) {
	if( word1.length != word2.length ) return false;
	if( word1 == word2 ) return false;
	final a1 = word1.toLowerCase().split( "" );
	final a2 = word2.toLowerCase().split( "" );
	a1.sort( stringSort );
	a2.sort( stringSort );
	
	for( i in 0...a1.length ) if( a1[i] != a2[i] ) return false;

	return true;
}

function stringSort( a:String, b:String ) {
	if( a < b ) return -1;
	if( a > b ) return 1;
	return 0;
}

function lastDigit( v:Int ) {
	final s = string( v );
	return s.charAt( s.length - 1 );
}