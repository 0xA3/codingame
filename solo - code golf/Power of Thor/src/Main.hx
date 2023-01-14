import CodinGame.readline;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 * ---
 * Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
 **/

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final lightX = Std.parseInt( inputs[0] ); // the X position of the light of power
		final lightY = Std.parseInt( inputs[1] ); // the Y position of the light of power
		final initialTX = Std.parseInt( inputs[2] ); // Thor's starting X position
		final initialTY = Std.parseInt( inputs[3] ); // Thor's starting Y position

		var thorX = initialTX;
		var thorY = initialTY;

		// imperative solution
 		while( true ) {
			
			readline(); // The remaining amount of turns Thor can move. Do not remove this line.

			var move = "";
			if( thorY < lightY ) {
				move = "S";
				thorY++;
			} else if( thorY > lightY ) {
				move = "N";
				thorY--;
			}
			
			var dx = "";
			if( thorX < lightX ) {
				move += "E";
				thorX++;
			} else if( thorX > lightX ) {
				move += "W";
				thorX--;
			}

			CodinGame.print( move );
		}
	}
}
