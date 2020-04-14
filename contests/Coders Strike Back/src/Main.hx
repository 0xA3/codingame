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
		
		final inputs = new Inputs();
		
		// final isCollectingCheckpoints = true;

		inputs.update();
		final pod = new Pod( inputs, 400 );
		final checkpoint0 = new Checkpoint( 0, new Position( inputs.nextCheckpointX, inputs.nextCheckpointY ));
		pod.update();
		CodinGame.print( '${checkpoint0.pos.x} ${checkpoint0.pos.y} 100' );
		
		final checkpoints:Array<Checkpoint> = [ checkpoint0 ];
		var hasAllCheckpoints = false;
		while( true ) {

			inputs.update();
			if( !hasAllCheckpoints ) {
				if( checkpoints.length > 1 && inputs.nextCheckpointX == checkpoints[0].pos.x && inputs.nextCheckpointY == checkpoints[0].pos.y ) {
					hasAllCheckpoints = true;
				} else {
					final lastCheckpoint = checkpoints[ checkpoints.length - 1 ];
					if( inputs.nextCheckpointX != lastCheckpoint.pos.x && inputs.nextCheckpointY != lastCheckpoint.pos.y ) {
						final checkpoint = new Checkpoint( lastCheckpoint.id + 1, new Position( inputs.nextCheckpointX, inputs.nextCheckpointY ));
						checkpoints.push( checkpoint );
					}
				}
			}

			final nextCheckpointIndex = getCheckpointIndex( checkpoints, inputs.nextCheckpointX, inputs.nextCheckpointY );
			final afterNextCheckpointIndex = nextCheckpointIndex + 1 < checkpoints.length ? nextCheckpointIndex + 1 : 0;

			CodinGame.printErr( 'nextCheckpointIndex $nextCheckpointIndex afterNextCheckpointIndex $afterNextCheckpointIndex' );
			pod.update();
			if( hasAllCheckpoints ) pod.steer2( checkpoints[nextCheckpointIndex], checkpoints[afterNextCheckpointIndex]) else pod.steer();
			CodinGame.print( '${pod.target.x} ${pod.target.y} ${pod.power}' );
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

