import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final s = readline();
	
	final result = process( s );
	print( result );
}

function process( s:String ) {
	if( s.length == 1 ) return 0;

	final n = s.length;
	var x = -1;
	var isPalindrome = false;
	while( !isPalindrome ) {
		x++;
		isPalindrome = true;
		for( i in 0...int(( n - x ) / 2 )) {
			if( s.charAt( x + i ) != s.charAt( n - i - 1 )) {
				isPalindrome = false;
				break;
			}
		}
	}

	return x;
}
