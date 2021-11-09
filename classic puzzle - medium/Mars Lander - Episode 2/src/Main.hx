import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final surfaceN = parseInt( CodinGame.readline()); // the number of points used to draw the surface of Mars.
		final surface = [for ( i in 0...surfaceN ) {
			var inputs = CodinGame.readline().split(' ');
			final landX = parseInt( inputs[0] ); // X coordinate of a surface point. (0 to 6999)
			final landY = parseInt( inputs[1] ); // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
			[landX, landY];
		}];

		printErr( surface );

		final marsLander = new MarsLander( surface );

		// game loop
		while (true) {
			
			var inputs = CodinGame.readline().split(' ');
			final x = parseInt( inputs[0] );
			final y = parseInt( inputs[1] );
			final hSpeed = parseInt( inputs[2] ); // the horizontal speed (in m/s), can be negative.
			final vSpeed = parseInt( inputs[3] ); // the vertical speed (in m/s), can be negative.
			final fuel = parseInt( inputs[4] ); // the quantity of remaining fuel in liters.
			final rotate = parseInt( inputs[5] ); // the rotation angle in degrees (-90 to 90).
			final power = parseInt( inputs[6] ); // the thrust power (0 to 4).

			final output = marsLander.update( x, y, hSpeed, vSpeed, fuel, rotate, power );
			
			print( output );
		}
	}
}
