import csb.Point;
/**
 * This code automatically collects game data in an infinite loop.
 * It uses the standard input to place data into the game variables such as x and y.
 * YOU DO NOT NEED TO MODIFY THE INITIALIZATION OF THE GAME VARIABLES.
 **/

class Main {
	
	static function main() {
		
		var boosted = false;
		
		// final checkpoints:Map<String, Point> = [];
		// final isCollectingCheckpoints = true;
		var lastPos = new Point();

		while( true ) {

			final inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt( inputs[0] ); // x position of your pod
			final y = Std.parseInt( inputs[1] ); // y position of your pod
			final nextCheckpointX = Std.parseInt( inputs[2] ); // x position of the next check point
			final nextCheckpointY = Std.parseInt( inputs[3] ); // y position of the next check point
			final nextCheckpointDist = Std.parseInt(inputs[4]); // distance to the next checkpoint
			final nextCheckpointAngle = Std.parseInt(inputs[5]); // angle between your pod orientation and the direction of the next checkpoint
			final inputs = CodinGame.readline().split(' ');
			final opponentX = Std.parseInt(inputs[0]);
			final opponentY = Std.parseInt(inputs[1]);

			// if( isCollectingCheckpoints ) {
			// 	final checkpointId = Std.string( nextCheckpointX ) + Std.string( nextCheckpointY );
			// 	if( !checkpoints.exists( checkpointId )) {
			// 		checkpoints.set( checkpointId, new Point( nextCheckpointX, nextCheckpointY ));
			// 	}
			// }
			
			final pos = new Point( x, y );
			
			final deltaPos = pos.distance2( lastPos );
			// CodinGame.printErr( 'deltaPos $deltaPos' );

			final nextCheckpointAngleRad = degToRad( nextCheckpointAngle );
			final thrust = Math.round( Math.max( 0, Math.min( 1, Math.cos( 0.5 * nextCheckpointAngleRad ) * 2 )) * 100 );
			CodinGame.printErr( 'nextCheckpointAngleRad $nextCheckpointAngleRad thrust $thrust' );
			
			// final thrust = Math.abs( nextCheckpointAngle ) > 90 ? 0 : Math.abs( nextCheckpointAngle ) > 80 ? 50 : 100;
			if( nextCheckpointDist > 5000 && Math.abs( nextCheckpointAngle ) < 20 && !boosted ) {
				CodinGame.print( '$nextCheckpointX $nextCheckpointY BOOST' );	
				boosted = true;
			} else {
				CodinGame.print( '$nextCheckpointX $nextCheckpointY $thrust' );
			}

			lastPos.x = x;
			lastPos.y = y;
		}
	}

	static function degToRad( deg:Float ):Float {
		return deg * Math.PI / 180;
	}

	static function radToDeg( rad:Float ):Float {
		return rad * 180 / Math.PI;
	}

	
	
}
