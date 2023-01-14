import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final content = [for( _ in 0...n ) readline().split( "" )].flatten();

	var total = 0;
	var cheeseLeft = 0;
	for( char in content ) {
		if( char.charAt( 0 ) == "*" ) cheeseLeft++;
		total++;
	}
	final percentage = int( cheeseLeft / total * 100 );
	
	print( '${percentage}%' );
}

