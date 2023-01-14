import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );

	final a = gcd( x, y );
	print( a );
	print( '${x / a} ${y / a}' );
}

function gcd( v1:Int, v2:Int ) {
	if( v2 == 0 ) return v1;
	else return gcd( v2, v1 % v2 );
}