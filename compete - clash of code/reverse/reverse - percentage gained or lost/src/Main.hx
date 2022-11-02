import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using xa3.NumberFormat;

function main() {

	var inputs = readline().split(' ');
	var v = parseFloat(inputs[0]);
	final n = parseInt(inputs[1]);
	
	for( _ in 0...n ) {
		final inputs = readline().split(" ");
		final type = inputs[0];
		final percentage = inputs[1].substr( 0, inputs[1].length - 1 );

		switch type {
			case "gained": v += v * ( parseInt( percentage ) / 100 );
			case "lost": v -= v * ( parseInt( percentage ) / 100 );
			default: // no-op
		}
	}	
	
	print( v.fixed( 2 ));
}
