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
	final letterScores = [for( score in scores ) for( letter in score.letters ) letter => score.points];

	final validWords = words.filter( word -> checkWord( word, availableLetters.copy() ));
	if( validWords.length == 0 ) throw 'Error: no valid words';

	final wordScores = validWords.map( word -> {
		word: word,
		score: word.split( "" ).fold(( letter, sum ) -> sum + letterScores[letter], 0 )
	});
	
	ArraySort.sort( wordScores, ( a, b ) -> b.score - a.score );
	// for( ws in wordScores ) trace( '${ws.score}  ${ws.word}' );

	return wordScores[0].word;
}

function checkWord( word:String, availableLetters:Array<String> ) {
	final lettersOfWord = word.split( "" );

	for( requiredLetter in lettersOfWord ) {
		if( availableLetters.contains( requiredLetter )) {
			availableLetters.remove( requiredLetter );
		} else return false;
	}
	// trace( 'word "$word" is possible' );
	return true;
}
