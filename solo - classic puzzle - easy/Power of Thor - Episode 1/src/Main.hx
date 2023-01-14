
/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 * ---
 * Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.
 **/

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final lightX = Std.parseInt(inputs[0]); // the X position of the light of power
		final lightY = Std.parseInt(inputs[1]); // the Y position of the light of power
		final initialTX = Std.parseInt(inputs[2]); // Thor's starting X position
		final initialTY = Std.parseInt(inputs[3]); // Thor's starting Y position

		var thorX = initialTX;
		var thorY = initialTY;

		// imperative solution
/* 		while (true) {
			
			final remainingTurns = Std.parseInt( CodinGame.readline()); // The remaining amount of turns Thor can move. Do not remove this line.

			var dx = "";
			if( thorX < lightX ) {
				dx = "E";
				thorX++;
			} else if( thorX > lightX ) {
				dx = "W";
				thorX--;
			}
			var dy = "";
			if( thorY < lightY ) {
				dy = "S";
				thorY++;
			} else if( thorY > lightY ) {
				dy = "N";
				thorY--;
			}

			CodinGame.print( dy + dx );
		}
 */		
		// declarative solution
		final deltaY = lightY - thorY;
		final deltaX = lightX - thorX;
		
		final vy = deltaY == 0 ? "" : deltaY > 0 ? "S" : "N";
		final vx = deltaX == 0 ? "" : deltaX > 0 ? "E" : "W";
		
		final xSteps = Math.abs( deltaX );
		final ySteps = Math.abs( deltaY );

		final totalSteps = Std.int( Math.max( xSteps, ySteps ));
		final yxSteps = [for( i in 0...totalSteps ) ( i < ySteps ? vy : "" ) + ( i < xSteps ? vx : "" )];

		// untyped console.error( 'yxSteps $yxSteps' );

		for( i in 0...totalSteps ) {
			final remainingTurns = Std.parseInt( CodinGame.readline()); // The remaining amount of turns Thor can move. Do not remove this line.

			CodinGame.print( yxSteps[i] );
		}
	}
}
