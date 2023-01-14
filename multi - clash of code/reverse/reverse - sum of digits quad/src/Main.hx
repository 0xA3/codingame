import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = readline();
	final sum = n.split( "" ).map( s -> parseInt( s )).fold(( v, sum ) -> sum + v, 0 );
	print( sum * sum );
}
