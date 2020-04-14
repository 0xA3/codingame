package csb;

class Pod extends Unit {
	
	public var angle:Float;
	public var nextCheckPointId:Int;
	public var checked:Int;
	public var timeout:Int;
	public var partner:Pod;
	public var shield:Bool;

	public function getAngle( p:Point ):Float {
		
		final d = distance( p );
		final dx = ( p.x - this.x ) / d;
		final dy = ( p.y - this.y ) / d;

		// Simple trigonometry. We multiply by 180.0 / PI to convert radiants to degrees.
		var a = Math.acos( dx ) * 180.0 / Math.PI;

		// If the point I want is below me, I have to shift the angle for it to be correct
		if (dy < 0) {
			a = 360.0 - a;
		}

		return a;
	}

	public function diffAngle( p:Point ):Float {
		
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

	public function rotate( p:Point ) {
		
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

	public function boost( thrust:Int ) {
		// Don't forget that a pod which has activated its shield cannot accelerate for 3 turns
		if (this.shield) {
			return;
		}

		// Conversion of the angle to radiants
		final ra = this.angle * Math.PI / 180.0;

		// Trigonometry
		this.vx += Math.cos( ra ) * thrust;
		this.vy += Math.sin( ra ) * thrust;
	}

	public function move( t:Float ) {
		this.x += this.vx * t;
    	this.y += this.vy * t;
	}

	public function end() {
		
		this.x = Math.round( this.x );
		this.y = Math.round( this.y );
		this.vx = Std.int( this.vx * 0.85 );
		this.vy = Std.int( this.vy * 0.85 );

		// Don't forget that the timeout goes down by 1 each turn. It is reset to 100 when you pass a checkpoint
		this.timeout -= 1;
	}

	public function play( p:Point, thrust:Int ) {
		
		this.rotate( p );
		this.boost( thrust );
		this.move( 1.0 );
		this.end();
	}

	

}