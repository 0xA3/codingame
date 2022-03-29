import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using StringTools;

function main() {

	final s = readline();
	final values = ( s.charAt( 0 ) == "-" ? s.substr( 2 ) : s.substr( 1 )).split( "" ).map( s -> parseInt( s ));
	final multiplier = parseInt( s.charAt( 0 ) == "-" ? s.substr( 0, 2 ) : s.substr( 0, 1 ));
	
	var sum = 0;
	for( v in values ) {
		if( v == null ) {
			print( "INVALID" );
			return;
		}
		sum += v;
	}
	
	if( multiplier == null ) {
		print( "INVALID" );
		return;
	}
	
	print( string( multiplier * sum ));
}
