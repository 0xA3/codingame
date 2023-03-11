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

function process( inputA:Int, inputB:Int ) {
	final lines = [];

	var remainder = 0;
	var a = inputA;
	var b = inputB;
	var previousRemainder = b;
	while( true ) {
		remainder = a % b;
		lines.push( '$a=$b*${int( a / b )}+$remainder' );	
		if( a % b == 0 ) break;
		previousRemainder = remainder;
		a = b;
		b = remainder;
	}
	lines.push( 'GCD($inputA,$inputB)=$previousRemainder' );
	
	final output = lines.join( "\n" );

	return output;
}
