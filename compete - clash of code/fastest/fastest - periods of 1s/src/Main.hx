import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	final l = readline();
	
	var last1 = -1;
	final periods = [];
	for( i in 0...n ) {
		if( l.charAt( i ) == "1" ) {
			if( last1 == -1 ) last1 = i;
			else {
				periods.push( i - last1 );
				last1 = i;
			}
		}
	}
	final firstPeriod = periods[0];
	
	for( i in 1...periods.length ) {
		if( periods[i] != firstPeriod ) {
			print( "false" );
			return;
		}
	}
	print( '$firstPeriod' );
}
