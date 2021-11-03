import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final k = parseInt( readline());
	final lines = [for( i in 0...10 ) readline().split( "" )];
					
	final game = new Game( lines );
	game.init();

	while( true ) {
		final inputs = readline().split(' ');
		final eneY = parseInt( inputs[0] );
		final eneX = parseInt( inputs[1] );

		final output = game.step( eneX, eneY );
		print( output );
	}
	
}
