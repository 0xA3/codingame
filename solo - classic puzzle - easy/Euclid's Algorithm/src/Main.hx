import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;

var lines:Array<String>;

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	final result = process( a, b );
	print( result );
}

function process( a:Int, b:Int ) {
	lines = [];
	lines.push( 'GCD($a,$b)=${gcd( a, b )}' );
	
	final output = lines.join( "\n" );
	return output;
}

function gcd( a:Int, b:Int ) {
	final r = a % b;
	lines.push( '$a=$b*${int( a / b )}+$r' );
	if( r == 0 ) return b;
	else return gcd( b, r );
}
