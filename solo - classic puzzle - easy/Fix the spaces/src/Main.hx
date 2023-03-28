import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.GenericStack;

using Lambda;

var solutions:Array<String>;
var stack:GenericStack<String>;

function main() {

	final original = readline();
	final words = readline().split(" ");
	
	final result = process( original, words );
	print( result );
}

function process( original:String, words:Array<String> ) {
	solutions = [];
	stack = new GenericStack<String>();
	
	words.sort(( a, b ) -> a.length - b.length );
	trace( words );
	solveRecursive( original, words );

	if( solutions.length == 1 ) {
		return solutions[0];
	} else {
		return "Unsolvable";
	}
}

function solveRecursive( s:String, words:Array<String> ) {
	if( words.length == 0 ) addSolution();
	
	// trace( 'string: $s  words $words' );
	var i = 0;
	while( i < words.length && solutions.length < 2 ) {
		final word = words[i];
		final sub = s.substr( 0, word.length );
		// trace( 'test word $word' );
		if( sub == word ) {
			stack.add( word );
			solveRecursive( s.substr( word.length ), words.slice( 0, i ).concat( words.slice( i + 1 )));
			stack.pop();
		}
		i++;
	}
}

function addSolution() {
	final array = [for( word in stack ) word];
	array.reverse();
	final solution = array.join(" ");
	if( !solutions.contains( solution )) solutions.push( solution );
}