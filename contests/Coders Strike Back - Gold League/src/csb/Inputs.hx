package csb;

class Inputs {
	
	final pods:Array<Pod>;
	final opponents:Array<Pod>;
	
	public function new( pods:Array<Pod>, opponents:Array<Pod> ) {
		this.pods = pods;
		this.opponents = opponents;
	}

	public function update() {
		
		for ( i in 0...2 ) {
			var inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt(inputs[0]); // x position of your pod
			final y = Std.parseInt(inputs[1]); // y position of your pod
			final vx = Std.parseInt(inputs[2]); // x speed of your pod
			final vy = Std.parseInt(inputs[3]); // y speed of your pod
			final angle = Std.parseInt(inputs[4]); // angle of your pod
			final nextCheckPointId = Std.parseInt(inputs[5]); // next check point id of your pod
			pods[i].update( x, y, vx, vy, angle, nextCheckPointId );
		}
		for ( i in 0...2 ) {
			var inputs = CodinGame.readline().split(' ');
			final x = Std.parseInt(inputs[0]); // x position of the opponent's pod
			final y = Std.parseInt(inputs[1]); // y position of the opponent's pod
			final vx = Std.parseInt(inputs[2]); // x speed of the opponent's pod
			final vy = Std.parseInt(inputs[3]); // y speed of the opponent's pod
			final angle = Std.parseInt(inputs[4]); // angle of the opponent's pod
			final nextCheckPointId = Std.parseInt(inputs[5]); // next check point id of the opponent's pod
			opponents[i].update( x, y, vx, vy, angle, nextCheckPointId );
		}

		
	}
}