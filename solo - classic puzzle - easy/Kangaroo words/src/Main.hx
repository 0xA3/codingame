import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final n = parseInt( readline() );
	final lines = [for( _ in 0...n ) readline()];
		
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	final wordsOfLines = lines.map( line -> line.split( ", " ));

	final outputs = [];
	for( words in wordsOfLines ) {
		for( word in words ) {
			final joeyWords = findJoeyWords( word, words );
			if( joeyWords.length > 0 ) outputs.push( '$word: ${joeyWords.join( ", " )}' );
		}
	}
	outputs.sort(( a, b ) -> a < b ? -1 : 1 );
	
	return outputs.length > 0 ? outputs.join( "\n" ) : "NONE";
}

function findJoeyWords( kangarooWord:String, testWords:Array<String> ) {
	// trace( 'kangarooWord $kangarooWord' );
	var joeyWords = [];
	for( testWord in testWords ) {
		if( testWord == kangarooWord ) continue;
		if( testWord.length > kangarooWord.length ) continue;
		// trace( 'check $testWord' );

		var isJoeyWord = true;
		var c1 = 0;
		for( i in 0...testWord.length ) {
			final char = testWord.charAt( i );
			final index = kangarooWord.indexOf( char, c1 );
			// trace( 'char $char  index $index' );
			if( index == -1 ) {
				isJoeyWord = false;
				break;
			}
			c1 = index + 1;
		}
		if( isJoeyWord ) joeyWords.push( testWord );
	}

	return joeyWords;
}
