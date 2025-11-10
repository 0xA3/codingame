import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Main;
using StringTools;

inline var MINUTES_PER_DAY = 60 * 24;

function main() {
	
	final offsets = readline().split(" ");
	
	final result = process( offsets );
	print( result );
}

function process( offsets:Array<String> ) {
	final offsetMinutes = offsets.map( parseOffset );
	
	final anagrams = [];
	for( t in 0...MINUTES_PER_DAY ) {
		final time1 = minutesToTime( offsetMinutes[0] + t );
		final time2 = minutesToTime( offsetMinutes[1] + t );
		
		final sortedTime1 = sortCharsOfString( time1 );
		final sortedTime2 = sortCharsOfString( time2 );

		if( sortedTime1 == sortedTime2 ) {
			anagrams.push( '$time1, $time2' );
		}
	}
	
	anagrams.sort(( a, b ) -> {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	});

	return anagrams.join( "\n" );
}

function parseOffset( offset:String ) {
	final sign = offset.charAt( 0 );
	final hours = parseInt( offset.substr( 1, 2 ) );
	final minutes = parseInt( offset.substr( 3, 2 ) );

	return parseInt( '$sign${hours * 60 + minutes}' );
}

function minutesToTime( minutes:Int ) {
	final positiveMinutes = ( MINUTES_PER_DAY + minutes ) % MINUTES_PER_DAY;
	
	final hours = int( positiveMinutes / 60 );
	final minutes = positiveMinutes % 60;
	
	return '${doubleDigit( hours )}${doubleDigit( minutes )}';
}

function doubleDigit( v:Int ) return v < 10 ? '0$v' : '$v';

function sortCharsOfString( s:String ) {
	final a = s.split( "" );
	a.sort(( a, b ) -> {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	});
	
	return a.join( "" );
}