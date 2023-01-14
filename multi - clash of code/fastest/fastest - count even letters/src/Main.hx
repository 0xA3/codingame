import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.StringUtils;

/*
You must count all the letter in the sentence that are even in ASCII and output it. Other characters that are not alphabetical are to be ignored
*/

function main() {

	final m = readline().split( "" );
	final c2 = count2( m );
	print( c2 );
}

function count1( m:Array<String> ) {
	final count = m.fold(( s, sum ) -> {
		final charCode = s.charCodeAt( 0 );
		if(( charCode >= 65 && charCode <= 90 ) || ( charCode >= 97 && charCode <= 122 )) { 
			if( charCode % 2 == 0 ) sum + 1;
			else sum;
		} else sum;
	}, 0 );
	return count;
}

function count2( m:Array<String> ) {
	final evenChars = m.filter( s -> s.isLetter() && s.charCode() % 2 == 0 );
	return evenChars.length;	
}