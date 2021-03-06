package csb;

typedef Position = Vector2d;

class Vector2d {

	public var x:Float;
	public var y:Float;

	public function new( x = 0.0, y = 0.0 ) {
		this.x = x;
		this.y = y;
	}

	public function distance2( p:Position ):Float {
		return ( x - p.x )*( x - p.x ) + ( y - p.y )*( y - p.y );
	}

	public function distance( p:Position ):Float {
		return Math.sqrt( distance2( p ));
	}

	public function closest( a:Vector2d, b:Vector2d ):Vector2d {
		
		final da = b.y - a.y;
		final db = a.x - b.x;
		final c1 = da * a.x + db * a.y;
		final c2 = -db * this.x + da * this.y;
		final det = da*da + db*db;
		var cx = 0.0;
		var cy = 0.0;

		if (det != 0) {
			cx = (da*c1 - db*c2) / det;
			cy = (da*c2 + db*c1) / det;
		} else {
			// The Vector2d is already on the line
			cx = this.x;
			cy = this.y;
		}

		return new Vector2d(cx, cy);
	}
}