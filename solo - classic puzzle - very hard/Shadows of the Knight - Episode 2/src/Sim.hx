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
	
	static var knight:IKnight;

	static var x:Int;
	static var y:Int;
	static var bx:Int;
	static var by:Int;
	static var n:Int;

	static var dist2:Int;
	
	public static function main() {
		// final ip = Testcases.x10_0;
		final ip = Testcases.x100_0;
		// final ip = Testcases.aLotOfJumpsHorizontal;
		// final ip = Testcases.aLotOfJumpsHorizontalMirrored;
		// final ip = Testcases.lessJumpsHorizontal;
		// final ip = Testcases.towerHorizontal;
		// final ip = Testcases.exactNbOfJumpsHorizontalX;
		// final ip = Testcases.exactNbOfJumpsHorizontalY;
		// final ip = Testcases.xw5;
		
		// final ip = Testcases.x10_2;
		// final ip = Testcases.x10_10;
		
		// final ip = Testcases.aLotOfJumps;
		// final ip = Testcases.lessJumps;
		// final ip = Testcases.tower;
		// final ip = Testcases.lesserJumps;
		// final ip = Testcases.exactNbOfJumps;
		// final ip = Testcases.moreWindows;
		// final ip = Testcases.aLotOfWindows;
		// final ip = Testcases.soManyWindows;
		if( ip.bx >= ip.w ) {
			Sys.println( 'Error: Bomb x ${ip.bx} must be smaller than width ${ip.w}' );
			return;
		}

		if( ip.by >= ip.h ) {
			Sys.println( 'Error: Bomb y ${ip.by} must be smaller than height ${ip.h}' );
			return;
		}

		// knight = new Denvash( ip.w, ip.h, ip.n, ip.x, ip.y );
		// knight = new Ethiery( ip.w, ip.h, ip.n, ip.x, ip.y );
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
		final command = knight.move( bombDir );
		turn++;
		

		final roundsLeft = n - turn;
		final info = roundsLeft >= 0 ? '$roundsLeft rounds left' : '${-roundsLeft} over max';
		Sys.println( '> $command  $info' );

		// if( turn == 3 ) Sys.exit( 0 );


		final pos = command.split(" ").map( s -> parseInt( s ));
		if( pos[0] == bx && pos[1] == by ) {
			if( roundsLeft >= 0 ) Sys.println( 'Bomb located in $turn turns' );
			else Sys.println( 'Failure: you are ${-roundsLeft)} ${(roundsLeft == -1 ) ? "turn" : "turns"} too late.' );
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