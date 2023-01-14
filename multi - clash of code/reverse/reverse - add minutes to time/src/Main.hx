import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using xa3.NumberFormat;

function main() {

	final n = parseInt( readline());
	final stime = readline().split( ":" ).map( s -> parseInt( s ));

	final m = stime[0] * 60 + stime[1] + n;
	
	final hours = int( m / 60 ) % 24;
	final minutes = m % 60;
	
	print( '${hours.double()}:${minutes.double()}' );
}
