import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.GenericStack;

using Lambda;

var solutions:Array<String>;
var stack:GenericStack<String>;
var wordsCount:Int;

function main() {

	final original = readline();
	final words = readline().split(" ");
	
	final result = process( original, words );
	print( result );
}

function process( original:String, words:Array<String> ) {
	solutions = [];
	final wordsMap:Map<String, Int> = [];
	for( word in words ) {
		if( !wordsMap.exists( word )) wordsMap.set( word, 1 );
		else wordsMap[word]++;
	}
	wordsCount = words.length;
	stack = new GenericStack<String>();
	
	solveRecursive( original, wordsMap );

	if( solutions.length == 1 ) {
		return solutions[0];
	} else {
		return "Unsolvable";
	}
}

function solveRecursive( s:String, wordsMap:Map<String, Int>, depth = 0 ) {
	if( wordsCount == 0 ) addSolution();
	
	var i = 0;
	for( word => count in wordsMap ) {
		if( solutions.length > 1 ) return;

		// trace( 'test word $word' );
		if( s.substr( 0, word.length ) == word ) {
			// trace( 'depth $depth  i $i   $word   ${s.substr( word.length )}' );
			stack.add( word );
			if( count > 1 ) wordsMap[word]--;
			else wordsMap.remove( word );
			wordsCount--;

			solveRecursive( s.substr( word.length ), wordsMap, depth + 1 );
			
			if( !wordsMap.exists( word )) wordsMap.set( word, 1 );
			else wordsMap[word]++;
			stack.pop();
			wordsCount++;
		}
		i++;
	}
}

function addSolution() {
	final array = [for( word in stack ) word];
	array.reverse();
	final solution = array.join(" ");
	// trace( 'found $solution' );
	if( !solutions.contains( solution )) solutions.push( solution );
}