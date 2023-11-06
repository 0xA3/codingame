import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.ds.ArraySort;

using Lambda;

final scores = [
	{ letters: ["e", "a", "i", "o", "n", "r", "t", "l", "s", "u"], points: 1 },
	{ letters: ["d", "g"], points: 2 },
	{ letters: ["b", "c", "m", "p"], points: 3 },
	{ letters: ["f", "h", "v", "w", "y"], points: 4 },
	{ letters: ["k"], points: 5 },
	{ letters: ["j", "x"], points: 8 },
	{ letters: ["q", "z"], points: 10 }
];

function main() {
	final n = parseInt( readline() );
	final words = [for( _ in 0...n ) readline()];
	final availableLetters = readline().split( "" );

	final result = process( words, availableLetters );
	print( result );
}

function process( words:Array<String>, availableLetters:Array<String> ) {

	availableLetters.sort( sortLetters );
	final validWords = words.filter( word -> checkValidity( word, availableLetters ));
	if( validWords.length == 0 ) throw 'Error: no valid words';
	
	final letterScores = [for( score in scores ) for( letter in score.letters ) letter => score.points];

	final wordScores = validWords.map( word -> { word: word, score: getWordScore( word, letterScores ) });
	ArraySort.sort( wordScores, ( a, b ) -> b.score - a.score );
	// for( ws in wordScores ) trace( '${ws.score}  ${ws.word}' );

	return wordScores[0].word;
}

function getWordScore( word:String, letterScores:Map<String, Int> ) {
	return word.split( "" ).fold(( letter, sum ) -> sum + letterScores[letter], 0 );
}

function checkValidity( word:String, availableLetters:Array<String> ) {
	final lettersOfWord = word.split( "" );
	lettersOfWord.sort( sortLetters );

	// trace( 'word "$word"  available letters ${availableLetters.join( "" )}' );
	var position = 0;
	for( requiredLetter in lettersOfWord ) {
		// trace( 'required letter $requiredLetter' );
		while( true ) {
			if( position == availableLetters.length ) {
				// trace( 'no more letters' );
				return false;
			}
			final availableLetter = availableLetters[position];
			// trace( 'pos $position: $availableLetter' );
			if( availableLetter < requiredLetter ) {
				position++;
			} else if( availableLetter > requiredLetter ) {
				// trace( 'word "$word" is not possible' );
				return false;
			} else {
				// trace( 'match' );
				position++;
				break;
			}
		}
	}
	// trace( 'word "$word" is possible' );
	return true;
}

function sortLetters( a:String, b:String ) {
	if( a < b ) return -1;
	if( a > b ) return 1;
	return 0;
}