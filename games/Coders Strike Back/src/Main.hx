/**
 * This code automatically collects game data in an infinite loop.
 * It uses the standard input to place data into the game variables such as x and y.
 * YOU DO NOT NEED TO MODIFY THE INITIALIZATION OF THE GAME VARIABLES.
 **/

class Main {
	
	static function main() {
		
		var boosted = false;

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

			final thrust = nextCheckpointAngle > 90 || nextCheckpointAngle < -90 ? 0 : nextCheckpointAngle > 80 || nextCheckpointAngle < -80 ? 50 : 100;
			if( nextCheckpointDist > 10000 && Math.abs( nextCheckpointAngle ) < 18 && !boosted ) {
				CodinGame.print( '$nextCheckpointX $nextCheckpointY BOOST' );	
				boosted = true;
			} else {
				CodinGame.print( '$nextCheckpointX $nextCheckpointY $thrust' );
			}
		}
	}
}
