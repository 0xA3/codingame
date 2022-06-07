import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	
	var sum = 1;
	for( _ in 0...n ) {
		final inputs = readline().split(' ');
		sum += parseInt( inputs[0] );
		sum -= parseInt( inputs[1] );
	}
	
	print( '${sum}' );
}
