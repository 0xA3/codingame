import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

final digits = "01";

function main() {
	final total = parseInt( readline() );
	final symbols = [for( _ in 0...total ) readline()];
	
	final result = process( symbols );
	print( result );
}

function process( symbols:Array<String> ) {
	final bits = symbols.length;
	final combinations = int( pow( 2, bits ));

	final bin = [for( i in 0...combinations ) fillLeft( toBin( i ), bits )];
	final outputs = [];
	for( i in 1...bits ) {
		final set = bin.map( line -> line.replace( "0", symbols[i - 1] ).replace( "1", symbols[i] ));
		if( i == 1 ) bin.shift(); // eliminating all zeros after first iteration
		outputs.push( set.join( "\n" ));
	}

	return outputs.join( "\n" );
}

function toBin( v:Int ) {
	var encoded = "";
	var value = v;
	do {
		encoded = digits.charAt( value % 2 ) + encoded;
		value = int( value / 2 );
	} while( value > 0 );

	return encoded;
}

function fillLeft( s:String, length:Int ):String {
	while( s.length < length ) s = "0" + s;
	return s;
}

