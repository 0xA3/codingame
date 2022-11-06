import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

function main() {

	final t = readline();
	final t2 = readline();
	if( t > t2 ) print( "EARLY" );
	else if( t < t2 ) print( "DELAYED" );
	else print( "ON TIME" );
}

