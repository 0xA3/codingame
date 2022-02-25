import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.Ai;

using Lambda;

class Main {
	
	static function main() {

		final inputs = readline().split(' ');
		final r = parseInt( inputs[0] ); // number of rows.
		final c = parseInt( inputs[1] ); // number of columns.
		final a = parseInt( inputs[2] ); // number of rounds between the time the alarm countdown is activated and the time the alarm goes off.
		
		printErr( 'rows $r columns $c alarm rounds $a' );

		final ai = new Ai( c, r );

		var fuel = 300; // arbitrary limit

		// game loop
		while( fuel-- > 0 ) {
			var inputs = readline().split(' ');
			final ky = parseInt(inputs[0]); // row where Kirk is located.
			final kx = parseInt(inputs[1]); // column where Kirk is located.
			
			final lines = [for( i in 0...r ) readline()];
			// printErr( lines.join( "\n" ));
			ai.update( lines );
			final direction = ai.getDirection( kx, ky );
		
			print( direction ); // Kirk's next move (UP DOWN LEFT or RIGHT).
		
		}
	}
}
