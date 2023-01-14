import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.Ai;
import data.Motorbike;
import data.State;
import haxe.Timer;
import sim.Simulator;

using Lambda;
using xa3.StringUtils;

class Main {
	
	static function main() {

		final m = parseInt( readline() ); // the amount of motorbikes to control
		final v = parseInt( readline() ); // the minimum amount of motorbikes that must survive
		final lanes = [for( _ in 0...4 ) '${readline()}${".".repeat( 20 )}'.split( "" ).map( s -> s == ".")]; //lanes of the road. A dot character . represents a safe space, a zero 0 represents a hole in the road.

		// printErr( 'motorbikes $m' );
		// printErr( 'survive $v' );
		// printErr( 'survive $v' );
		// for( lane in lanes ) printErr( lane );
		final input1 = '$m\n$v\n${lanes.join("\n")}';

		final ai = new Ai( new Simulator( lanes, m, v ));
		var turn = 0;
		var actions = [];
		// game loop
		while( true ) {
			final s = parseInt( readline()); // the motorbikes' speed
			// printErr( 'speed $s' );
			
			var maxX = 0;
			var alive = 0;
			var motorbikes:Array<Motorbike> = [];
			for( _ in 0...m ) {
				final inputs = readline().split(" ");
				final x = parseInt( inputs[0] ); // x coordinate of the motorbike
				final y = parseInt( inputs[1] ); // y coordinate of the motorbike
				final a = inputs[2] == "1"; // indicates whether the motorbike is activated "1" or destroyed "0"
				// if( a ) printErr( 'pos $x:$y' );
				motorbikes.push({ x: x, y: y, a: a });
				if( a ) {
					alive++;
					if( x > maxX ) maxX = x;
				}
			}
			
			final state:State = { speed: s, x: maxX, alive: alive, motorbikes: motorbikes }

			if( turn == 0 ) {
				final startTime = Timer.stamp();
				actions = ai.process( state );
				// if( Timer.stamp() - startTime > 0.15 )
				printErr( '${Timer.stamp() - startTime}ms' );
			}

			print( actions[turn] );
			
			turn++;
		}
	}
}
