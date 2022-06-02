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

	static var x:Int;
	static var y:Int;
	static var bx:Int;
	static var by:Int;
	static var n:Int;

	static var dist2:Int;
	
	public static function main() {
		final ip = Testcases.towerHorizontal;
		if( ip.bx >= ip.w ) {
			Sys.println( 'Error: Bomb x ${ip.bx} must be smaller than width ${ip.w}' );
			return;
		}

		if( ip.by >= ip.h ) {
			Sys.println( 'Error: Bomb y ${ip.by} must be smaller than height ${ip.h}' );
			return;
		}

		knight = new Knight( ip.w, ip.h, ip.n, ip.x, ip.y );

		x = ip.x;
		y = ip.y;
		bx = ip.bx;
		by = ip.by;
		n = ip.n;
		dist2 = distance2( x, y, bx, by );

		timer = new Timer( 250 );
		timer.run = step;
	}

	static function step() {
		final command = knight.navigate( bombDir );
		turn++;
		Sys.println( '> $command  - ${n - turn} rounds left' );
		
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