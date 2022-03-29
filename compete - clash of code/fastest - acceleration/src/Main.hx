import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	final points = [for( _ in 0...n ) readline().split(' ').map( s -> parseFloat( s ))];
	final accs = points.map( ps -> Math.sqrt( ps.fold(( v, sum ) -> sum + v * v, 0.0 ) ));

	final outputs = accs.map( v -> v >= 9 ? "OPEN" : "WAIT" );
	print( outputs.join( "\n" ));
}
