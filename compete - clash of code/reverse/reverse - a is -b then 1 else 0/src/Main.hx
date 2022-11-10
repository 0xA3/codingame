import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	
	if( a == -b ) print( 1 );
	else print( 0 );
}
