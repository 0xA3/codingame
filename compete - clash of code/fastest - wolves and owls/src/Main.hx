import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final rows = [for( i in 0...h ) readline()];
	
	var wolves = 0;
	var owls = 0;
	for( row in rows ) {
		for( i in 0...row.length - 5 ) if( row.substr( i, 5 ) == "|\\_/|" ) wolves++;
		for( i in 0...row.length - 4 ) if( row.substr( i, 4 ) == "(oo)" ) owls++;
	}

	print( '$wolves\n$owls' );
}
