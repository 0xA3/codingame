import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final ip = readline();
	final digits = ip.split( "." ).join( "" ).split( "" ).map( s -> parseInt( s ));
	
	final port = digits.fold(( v, sum ) -> sum + v, 0 ) * digits[0];
	
	print( '$port' );
}
