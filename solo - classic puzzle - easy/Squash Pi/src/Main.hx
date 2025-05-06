import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import CompileTime.readFile;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

final pi_encoded = readFile( "bin/pi_295k_encoded.txt" );

function main() {

	final index = parseInt( readline() );
	final n = parseInt( readline() );

	final result = process( index, n );
	print( result );
}

function process( index:Int, n:Int ) {
	var pi = "";
	for( i in 0...pi_encoded.length ) {
		final char = pi_encoded.charCodeAt( i );
		final number = char - "0".code;
		final numberString = '$number';
		final extendedNumberString = [for( _ in 0...4 - numberString.length ) "0"].join( "" ) + numberString;
		pi += extendedNumberString;
	}

	return pi.substr( index, n );
}
