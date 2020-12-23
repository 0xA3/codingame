import haxe.xml.Check;
import haxe.macro.Expr.ObjectField;
import csb.Pod;
import csb.Vector2d;
import csb.Inputs;
import csb.Checkpoint;

/**
 * This code automatically collects game data in an infinite loop.
 * It uses the standard input to place data into the game variables such as x and y.
 * YOU DO NOT NEED TO MODIFY THE INITIALIZATION OF THE GAME VARIABLES.
 **/

class Main {
	
	static inline var podRadius = 400;

	static function main() {


		final laps = Std.parseInt( CodinGame.readline());
		final checkpointCount = Std.parseInt( CodinGame.readline());
		
		final checkpoints:Array<Checkpoint> = [];
		for ( i in 0...checkpointCount ) {
			var inputs = CodinGame.readline().split(' ');
			final checkpointX = Std.parseInt(inputs[0]);
			final checkpointY = Std.parseInt(inputs[1]);
			checkpoints.push( new Checkpoint( i, new Position( checkpointX, checkpointY )));
		}

		final pods = [ new Pod( 0, 400, checkpoints ), new Pod( 0, 400, checkpoints ) ];
		final opponents = [ new Pod( 0, 400, checkpoints ), new Pod( 0, 400, checkpoints ) ];
		final inputs = new Inputs( pods, opponents );
		
		while( true ) {

			inputs.update();
			for( pod in pods ) {
				pod.navigate();
				CodinGame.print( '${pod.target.x} ${pod.target.y} ${pod.power}' );
			} 
			
		}

	}

	static function getCheckpointIndex( checkpoints:Array<Checkpoint>, checkpointX:Int, checkpointY:Int ):Int {

		for( i in 0...checkpoints.length ) {
			if( checkpoints[i].pos.x == checkpointX && checkpoints[i].pos.y == checkpointY ) {
				return i;
			}
		}
		return 0;
	}


}

