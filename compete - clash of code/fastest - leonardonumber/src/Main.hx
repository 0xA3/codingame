import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	print( l(n) );
}

function l( n:Int ) {
	if( n == 0 ) return 1;
	if( n == 1 ) return 1;
	if( n > 1 )	return l( n - 1 ) + l( n - 2 ) + 1;
	return 0;
}