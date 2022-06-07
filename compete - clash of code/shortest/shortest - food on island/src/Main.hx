import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import Std.parseInt;
class Main {
	
	static function main() {
		
		final f = parseInt( readline() );
		final p = parseInt( readline() );
		final e = parseInt( readline() );
		final s = parseInt( readline() );
		
		final dailyConsumed = p * s;
		if( e >= dailyConsumed ) {
			print( "Forever" );
		} else {
			final dailyLoss = e - dailyConsumed;
			final days = Math.floor( f / -dailyLoss );
			print( days );
		}
	}
}

