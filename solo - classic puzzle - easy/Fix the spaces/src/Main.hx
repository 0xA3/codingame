import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import haxe.ds.GenericStack;

using Lambda;

var solutions:Int;
var solution:GenericStack<String>;

function main() {

	final original = readline();
	final words = readline().split(" ");
	
	final result = process( original, words );
	print( result );
}

function process( original:String, words:Array<String> ) {
	solutions = 0;
	solution = new GenericStack<String>();
	
	final hasSolution = solveRecursive( original, words );
	
	if( hasSolution ) {
		final result = [for( word in solution ) word];
		result.reverse();
		return result.join(" ");
	} else {
		return "Unsolvable";
	}
}

function solveRecursive( s:String, words:Array<String> ) {
	if( words.length == 0 ) return true;
	// trace( '$s' );
	for( i in 0...words.length ) {
		final word = words[i];
		// trace( 'test word $word' );
		if( s.indexOf( word ) == 0 ) {
			solution.add( word );
			if( solveRecursive( s.substr( word.length ), words.slice( 0, i ).concat( words.slice( i + 1 ))) ) {
				solutions++;
				
				return true;
			} else {
				solution.pop();
			}
		}
	}
	
	return false;
}
