import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {

		final text = readline();
		final n = parseInt( readline());
		final words = [for( i in 0...n ) readline()];
		
		final result = process( text, words );
		print( result );
	}

	static function process( text:String, words:Array<String> ) {
		
		final cleanText = clean( text );
		
		final wordSolutions = words.map( word -> { word: word, solutions: search( word, cleanText ) }).filter( ws -> ws.solutions.length > 0 );
		wordSolutions.sort(( a, b ) -> b.word.length - a.word.length );
		// trace( solutions.map( solution -> solution.length ));
		return wordSolutions[0].solutions[0];
	}

	static function search( word:String, text:String ) {
		final chars = word.split( "" );
		if( chars.length == 0 ) throw "Error: empty word";
		if( chars.length < 2 ) throw 'Error: word $word must have at least 2 characters';
		
		final char0 = chars[0];
		final char1 = chars[1];

		final starts = getOffsets( text, char0, 0 );
		// trace( 'word $word  text $text  char $char0  starts $starts' );
		if( starts.length == 0 ) return [];
		
		final startsOffsets = starts.flatMap( start -> {
			final offsets = getOffsets( text, char1, start );
			offsets.map( offset -> [start, offset] );
		});
		// trace( 'word $word  startsOffsets $startsOffsets' );
		if( startsOffsets.length == 0 ) return [];
		
		final validStartsOffsets = startsOffsets.filter( startOffset -> checkOffset( chars, text, startOffset[0], startOffset[1] ));
		// trace( 'word $word  validStartsOffsets $validStartsOffsets' );
		if( validStartsOffsets.length == 0 ) return [];
		
		final solutions = validStartsOffsets.map( startOffset -> constructSolution( text, word.length, startOffset[0], startOffset[1] ));
		// trace( 'word $word  solutions $solutions' );
		if( solutions.length == 0 ) return [];
		
		solutions.sort(( a, b ) -> b.length - a.length );
		// trace( 'word $word $solutions' );
		return solutions;
	}

	static function clean( s:String ) {
		
		final lowercase = s.toLowerCase();
		final ereg = ~/[!@#$%^&* '"-=_+`~;:\(\)\[\]{}<>\/\\?,.\s]/g;
		final cleanText = ereg.replace( lowercase, "" );
		return cleanText;
	}

	static function getOffsets( text:String, char:String, start:Int ) {
		// trace( 'getOffsets text $text  char $char  start $start' );
		final offsets = [];
		var startIndex = start;
		while( true ) {
			final offset = text.indexOf( char, startIndex );
			if( offset == -1 ) break;
			offsets.push( offset - start );
			startIndex = offset + 1;
		}
		
		return offsets;		
	}

	static function checkOffset( chars:Array<String>, text:String, start:Int, offset:Int ) {
		// trace( 'checkOffset start $start  offset $offset' );
		for( i in 0...chars.length ) {
			final wordChar = chars[i];
			final totalOffset = start + i * offset;
			if( totalOffset > text.length ) return false;
			
			final textChar = text.charAt( totalOffset );
			// trace( 'checkOffset totalOffset $totalOffset  char $wordChar  textChar $textChar' );
			if( textChar != wordChar ) return false;
		}
		return true;
	}

	static function constructSolution( text:String, wordLength:Int, start:Int, offset:Int ) {

		var solution = text.charAt( start ).toUpperCase();
		var i = 1;
		while( true ) {
			final inbetween = text.substr( start + offset * ( i - 1 ) + 1, offset - 1 );
			final char = text.charAt( start + offset * i ).toUpperCase();
			solution += inbetween + char;
			i++;
			if( i >= wordLength ) break;
		}
		return solution;
	}

}
