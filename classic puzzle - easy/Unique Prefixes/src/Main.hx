import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static inline var LENGTH = 16;
	static inline var LENGTH_HALF = int( LENGTH / 2 );

	static function main() {
		
		final n = parseInt( readline() );
		final words = [for( i in 0...n ) readline()];
		
		final result = process( words );
		print( result );
	}

	static function process( words:Array<String> ) {
		
		final wordMap:Map<String, String> = [];
		for( word in words ) wordMap.set( word, "" );
		
		final uniqueWords = [for( word in wordMap.keys()) word];
		uniqueWords.sort(( a, b ) -> b.length - a.length );
		
		final maxLength = uniqueWords[0].length;
		
		final remainingWords = uniqueWords.copy();
		var chars = 1;
		while( chars <= maxLength && remainingWords.length > 0 ) {
			final prefixes = remainingWords.map( word -> word.substr( 0, int( min( chars, word.length ))));
			for( i in -prefixes.length + 1...1 ) {
				if( isUnique( prefixes, -i )) {
					wordMap.set( remainingWords[-i], prefixes[-i] );
					remainingWords.remove( remainingWords[-i] );
				}
			}
			chars++;
		}

		final result = [for( word in words ) wordMap[word]].join( "\n" );
		return result;
	}

	static function isUnique( prefixes:Array<String>, index:Int ) {
		final prefixToCheck = prefixes[index];
		for( i in 0...prefixes.length ) {
			if( i != index && prefixes[i] == prefixToCheck ) return false;
		}
		return true;
	}

}
