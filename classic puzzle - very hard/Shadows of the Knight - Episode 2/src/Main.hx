import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {
	
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] ); // width of the building.
	final h = parseInt( inputs[1] ); // height of the building.
	final n = parseInt( readline() ); // maximum number of turns before game over.
	var inputs = readline().split(' ');
	final x0 = parseInt( inputs[0] );
	final y0 = parseInt( inputs[1] );
	
	final knight = new Knight( w, h, n, x0, y0 );

	while( true ) {
		final result = knight.respond( readline() );
		print( result );
	}
}
