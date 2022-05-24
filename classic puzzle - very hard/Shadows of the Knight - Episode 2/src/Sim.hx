import haxe.Timer;
import Std.parseInt;
import Main.COLDER;
import Main.WARMER;
import Main.SAME;
import Main.UNKNOWN;

@:access( Main )
class Sim {
	
	static var x = 1;
	static var y = 5;

	static var bx = 4;
	static var by = 10;
	static var dist2 = distance2( x, y, bx, by );
	
	static var turn = 0;
	static var timer:Timer;

	static var bombDir = UNKNOWN;

	public static function main() {
		Main.init( 5, 16, 80, x, y );

		timer = new Timer( 250 );
		timer.run = step;
	}

	static function step() {
		final command = Main.process( bombDir );
		turn++;

		final pos = command.split(" ").map( s -> parseInt( s ));
		if( pos[0] == bx && pos[1] == by ) {
			Sys.println( 'Bomb located in $turn turns' );
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