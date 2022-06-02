import haxe.Timer;
import Std.parseInt;
import Knight.COLDER;
import Knight.WARMER;
import Knight.SAME;
import Knight.UNKNOWN;

class Sim {
	
	static var turn = 0;
	static var timer:Timer;

	static var bombDir = UNKNOWN;
	
	static var knight:Knight;

	static var x = 0;
	static var y = 0;
	static var bx = 1;
	static var by = 1;

	static var dist2 = distance2( x, y, bx, by );
	
	public static function main() {
		final width = 10;
		final height = 5;
		final maxJumps = 80;

		knight = new Knight( width, height, maxJumps, x, y );

		timer = new Timer( 250 );
		timer.run = step;
	}

	static function step() {
		final command = knight.navigate( bombDir );
		Sys.println( '> $command' );
		turn++;
		
		final pos = command.split(" ").map( s -> parseInt( s ));
		if( pos[0] == bx && pos[1] == by ) {
			Sys.println( 'Bomb located in $turn turns' );
			timer.stop();
		}
		final nextDist2 = distance2( pos[0], pos[1], bx, by );
		if( nextDist2 > dist2 ) bombDir = COLDER;
		else if( nextDist2 < dist2 ) bombDir = WARMER;
		else if( nextDist2 == dist2 ) bombDir = SAME;
		else bombDir = UNKNOWN;

		dist2 = nextDist2;
	}

	static function distance2( x1:Int, y1:Int, x2:Int, y2:Int ) {
		return ( x2 - x1 ) * ( x2 - x1) + ( y2 - y1 ) * ( y2 - y1 );
	}
}