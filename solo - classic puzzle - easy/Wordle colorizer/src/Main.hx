import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {
	final answer = readline();
	final n = parseInt( readline());
	final attempts = [for( _ in 0...n ) readline().split( "" )];
	
	final result = process( answer, attempts );
	print( result );
}

function process( answer:String, attempts:Array<Array<String>> ) {
	final results = [];
	for( attempt in attempts ) {
		final result = [for( _ in 0...5 ) "X"];
		var counted = "";
		for( i in 0...attempt.length ) {
			final letter = attempt[i];
			if( letter == answer.charAt( i )) {
				result[i] = "#";
				counted += letter;
			}
		}
		for( i in 0...attempt.length ) {
			final letter = attempt[i];
			if( result[i] != "#" && count( counted, letter ) != count( answer, letter )) {
				result[i] = "O";
				counted += letter;
			}
		}
		results.push( result.join( "" ));
	}
	return results.join( "\n" );
}

function count( word:String, letter:String ) {
	return word.split( "" ).filter( s -> s == letter ).length;
}