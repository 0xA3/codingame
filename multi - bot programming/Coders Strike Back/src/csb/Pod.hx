package csb;

import csb.Vector2d;

class Pod {
	
	final inputs:Inputs;
	public var position:Position;
	public var angle:Int;
	public var target:Vector2d;
	public var velocity = new Vector2d();
	public var radius:Float;
	public var thrust = 100;
	public var power = "";

	var boosted = false;

	public function new( inputs:Inputs, radius:Float ) {
		
		this.inputs = inputs;
		this.position = new Position( inputs.x, inputs.y );
		this.target = new Vector2d( inputs.nextCheckpointX, inputs.nextCheckpointY );
		this.angle = inputs.nextCheckpointAngle;
		this.radius = radius;
	}

	public function update() {

		velocity.x = inputs.x - position.x;
		velocity.y = inputs.y - position.y;

		position.x = inputs.x;
		position.y = inputs.y;
	}

	public function steer() {
		CodinGame.printErr( "steer1" );
		target.x = inputs.nextCheckpointX;
		target.y = inputs.nextCheckpointY;
		
		final nextCheckpointAngleRad = degToRad( inputs.nextCheckpointAngle );
		thrust = Math.round( Math.max( 0, Math.min( 1, Math.cos( 0.5 * nextCheckpointAngleRad ) * 2 )) * 100 );

		// final thrust = Math.abs( nextCheckpointAngle ) > 90 ? 0 : Math.abs( nextCheckpointAngle ) > 80 ? 50 : 100;
		if( inputs.nextCheckpointDist > 5000 && Math.abs( inputs.nextCheckpointAngle ) < 20 && !boosted ) {
			power = 'BOOST' ;	
			boosted = true;
		} else {
			power = Std.string( thrust );
		}
	}

	public function steer2( nextCheckpoint:Checkpoint, afterNextCheckpoint:Checkpoint ) {
		
		final x10 = position.x + velocity.x * 2;
		final y10 = position.y + velocity.y * 2;
		
		if( nextCheckpoint.pos.distance( new Position( x10, y10 )) < nextCheckpoint.radius ) {
			target.x = afterNextCheckpoint.pos.x;
			target.y = afterNextCheckpoint.pos.y;
			power = "0";
			CodinGame.printErr( 'steer2 afterNext' );
		} else {
			steer();
		}

	}

	static inline function degToRad( deg:Float ):Float {
		return deg * Math.PI / 180;
	}

}