package csb;

import csb.Vector2d;

class Pod {
	
	public final id:Int;
	public final radius:Float;
	public final checkpoints:Array<Checkpoint>;

	public var position = new Position();
	public var velocity = new Vector2d();
	public var angle:Float;
	public var nextCheckpointId:Int;

	public var target = new Vector2d();
	public var thrust = 100;
	public var power = "";

	var boosted = false;

	public function new( id:Int, radius:Float, checkpoints:Array<Checkpoint> ) {
		
		this.id = id;
		this.radius = radius;
		this.checkpoints = checkpoints;
	}

	public function update( x:Int, y:Int, vx:Int, vy:Int, angle:Int, nextCheckpointId:Int ) {

		position.x = x;
		position.y = y;
		velocity.x = vx;
		velocity.y = vy;
		this.angle = angle;
		this.nextCheckpointId = nextCheckpointId;
	}

	public function navigate() {
		
		final nextCheckpoint = checkpoints[nextCheckpointId];
		final afterNextCheckpoint = checkpoints[(nextCheckpointId + 1 ) % checkpoints.length ];

		// CodinGame.printErr( 'pod $id nextCheckpoint ${nextCheckpoint.id} afterNextCheckpoint ${afterNextCheckpoint.id}' );

		final x10 = position.x + velocity.x * 2;
		final y10 = position.y + velocity.y * 2;
		
		if( nextCheckpoint.pos.distance( new Position( x10, y10 )) < nextCheckpoint.radius ) {
			target.x = afterNextCheckpoint.pos.x;
			target.y = afterNextCheckpoint.pos.y;
			power = "0";
		} else {
			steer( nextCheckpoint );
		}
	}

	public function steer( nextCheckpoint:Checkpoint ) {
		
		target.x = nextCheckpoint.pos.x;
		target.y = nextCheckpoint.pos.y;
		final nextCheckpointAngle = diffAngle( nextCheckpoint.pos );
		final nextCheckpointDist = position.distance( nextCheckpoint.pos );
		
		// CodinGame.printErr( 'id $id angle $nextCheckpointAngle' );
		
		final nextCheckpointAngleRad = degToRad( nextCheckpointAngle );
		thrust = Math.round( Math.max( 0, Math.min( 1, Math.cos( 0.5 * nextCheckpointAngleRad ) * 2 )) * 100 );

		if( nextCheckpointDist > 5000 && Math.abs( nextCheckpointAngle ) < 20 && !boosted ) {
			power = 'BOOST' ;	
			boosted = true;
		} else {
			power = Std.string( thrust );
		}
	}

	public function getAngle( p:Vector2d ):Float {
		
		final d = position.distance( p );
		final dx = ( p.x - position.x ) / d;
		final dy = ( p.y - position.y ) / d;

		// Simple trigonometry. We multiply by 180.0 / PI to convert radiants to degrees.
		var a = Math.acos( dx ) * 180.0 / Math.PI;

		// If the point I want is below me, I have to shift the angle for it to be correct
		if (dy < 0) {
			a = 360.0 - a;
		}

		return a;
	}

	public function diffAngle( p:Vector2d ):Float {
		
		final a = this.getAngle(p);

		// To know whether we should turn clockwise or not we look at the two ways and keep the smallest
		// The ternary operators replace the use of a modulo operator which would be slower
		final right = this.angle <= a ? a - this.angle : 360.0 - this.angle + a;
		final left = this.angle >= a ? this.angle - a : this.angle + 360.0 - a;

		if (right < left) {
			return right;
		} else {
			// We return a negative angle if we must rotate to left
			return -left;
		}
	}

	public function rotate( p:Vector2d ) {
		
		var a = this.diffAngle( p );

		// Can't turn by more than 18° in one turn
		if ( a > 18.0 ) {
			a = 18.0;
		} else if (a < -18.0) {
			a = -18.0;
		}

		this.angle += a;

		// The % operator is slow. If we can avoid it, it's better.
		if ( this.angle >= 360.0 ) {
			this.angle = this.angle - 360.0;
		} else if (this.angle < 0.0) {
			this.angle += 360.0;
		}
	}


	static inline function degToRad( deg:Float ):Float {
		return deg * Math.PI / 180;
	}

}