package csb;

class Inputs {
	
	public var x = 0;
	public var y = 0;
	public var nextCheckpointX = 0;
	public var nextCheckpointY = 0;
	public var nextCheckpointDist = 0;
	public var nextCheckpointAngle = 0;
	public var opponentX = 0;
	public var opponentY = 0;

	public function new() {}

	public function update() {
		
		final inputs = CodinGame.readline().split(' ');
		x = Std.parseInt( inputs[0] ); // x position of your pod
		y = Std.parseInt( inputs[1] ); // y position of your pod
		nextCheckpointX = Std.parseInt( inputs[2] ); // x position of the next check point
		nextCheckpointY = Std.parseInt( inputs[3] ); // y position of the next check point
		nextCheckpointDist = Std.parseInt( inputs[4] ); // distance to the next checkpoint
		nextCheckpointAngle = Std.parseInt( inputs[5] ); // angle between your pod orientation and the direction of the next checkpoint
		final inputs2 = CodinGame.readline().split(' ');
		opponentX = Std.parseInt( inputs2[0] );
		opponentY = Std.parseInt( inputs2[1] );
	}
}