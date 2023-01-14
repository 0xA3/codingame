/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

class Main {
	
	static function main() {
		
		final surfaceN = Std.Std.parseInt( CodinGame.readline()); // the number of points used to draw the surface of Mars.
		for ( i in 0...surfaceN ) {
			var inputs = CodinGame.readline().split(' ');
			final landX = Std.Std.parseInt( inputs[0] ); // X coordinate of a surface point. (0 to 6999)
			final landY = Std.Std.parseInt( inputs[1] ); // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
		}

		// game loop
		while (true) {
			
			var inputs = CodinGame.readline().split(' ');
			final X = Std.parseInt( inputs[0] );
			final Y = Std.parseInt( inputs[1] );
			final hSpeed = Std.parseInt( inputs[2] ); // the horizontal speed (in m/s), can be negative.
			final vSpeed = Std.parseInt( inputs[3] ); // the vertical speed (in m/s), can be negative.
			final fuel = Std.parseInt( inputs[4] ); // the quantity of remaining fuel in liters.
			final rotate = Std.parseInt( inputs[5] ); // the rotation angle in degrees (-90 to 90).
			final power = Std.parseInt( inputs[6] ); // the thrust power (0 to 4).

			// Write an action using console.log()
			// To debug: console.error('Debug messages...');


			// 2 integers: rotate power. rotate is the desired rotation angle (should be 0 for level 1), power is the desired thrust power (0 to 4).
			
			final dPower = vSpeed <= -40 ? Math.min( 4, power + 1 ) : power;
			CodinGame.print( '0 $dPower' );
		}
	}
}
