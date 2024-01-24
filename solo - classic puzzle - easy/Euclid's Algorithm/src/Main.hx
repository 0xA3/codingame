import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	final result = process( a, b );
	print( result );
}

function process( a:Int, b:Int ) {
	final lines = [];
	final gcd = gcd( lines, a, b );
	lines.push( 'GCD($a,$b)=${gcd}' );
	
	final output = lines.join( "\n" );
	return output;
}

function gcd( lines:Array<String>, a:Int, b:Int ) {
	final r = a % b;
	lines.push( '$a=$b*${int( a / b )}+$r' );
	if( r == 0 ) return b;
	else return gcd( lines, b, r );
}
