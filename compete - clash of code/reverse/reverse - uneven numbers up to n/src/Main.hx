import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final n = parseInt( readline());

	if( n <= 0 ) print( 0 );
	else {
		final nums = [for( i in 1...n + 1 ) if( i % 2 == 1 ) i];
		print( nums.join(" ") );
	}
}
