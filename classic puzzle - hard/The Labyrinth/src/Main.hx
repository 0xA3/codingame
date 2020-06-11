using Lambda;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

class Main {
	
	static function main() {

		final inputs = readline().split(' ');
		final r = parseInt( inputs[0] ); // number of rows.
		final c = parseInt( inputs[1] ); // number of columns.
		final a = parseInt( inputs[2] ); // number of rounds between the time the alarm countdown is activated and the time the alarm goes off.
		
		printErr( 'rows $r columns $c alarm rounds $a' );

		final maze = new Maze( c, r );
		final kirk = new Kirk( maze );

		// game loop
		while (true) {
			var inputs = readline().split(' ');
			final kr = parseInt(inputs[0]); // row where Kirk is located.
			final kc = parseInt(inputs[1]); // column where Kirk is located.
			printErr( 'kr $kr kc $kc' );
			kirk.update( kc, kr );
			
			final lines = [for( i in 0...r ) readline()];
			printErr( lines.join( "\n" ));
			maze.update( lines );
		
			kirk.navigate();
			// Write an action using console.log()
			// To debug: console.error('Debug messages...');
		
			final direction = kirk.getDirection();
			print( direction );     // Kirk's next move (UP DOWN LEFT or RIGHT).
		
		}
	}

}
