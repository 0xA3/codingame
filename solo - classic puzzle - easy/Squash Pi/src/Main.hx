import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import CompileTime.readFile;
import Std.int;
import Std.parseInt;

using Lambda;
using Main;

final pi_295k = readFile( "src/pi_295k.txt" );

function main() {

	final index = parseInt( readline() );
	final n = parseInt( readline() );

	final result = process( index, n );
	print( result );
}

function process( index:Int, n:Int ) {
	return pi_295k.substr( index, n );
}
