import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import Std.parseInt;

/*
We usually say that the screen size of a device by its diagonal, but you are now sent to complete a mission: find the device's length and width.
What you have (input) is down below.

Output
One line including the length and width of the device in inches, correct to 2 decimal places, separated by ' x ' (spacexspace).

Input
65
16:9

Output
56.65 x 31.87
*/

class Main {
	
	static function main() {
		
		final diag = parseInt( readline());
		final ratio = readline();

		print( process( diag, ratio ));
	}

	static inline function process( c:Int, ratio:String ) {
		final rs = ratio.split( ":" );
		final alpha = Math.atan( parseInt( rs[1] ) / parseInt( rs[0] ));

		return '${Math.round( c * Math.cos( alpha ) * 100 ) / 100} x ${Math.round( c * Math.sin( alpha ) * 100 ) / 100}';
	}
}

