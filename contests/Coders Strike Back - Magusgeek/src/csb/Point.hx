package csb;

class Point {

	public var x:Float;
	public var y:Float;

	public function new( x = 0.0, y = 0.0 ) {
		this.x = x;
		this.y = y;
	}

	public function distance2( p:Point ):Float {
		return ( x - p.x )*( x - p.x ) + ( y - p.y )*( y - p.y );
	}

	public function distance( p:Point ):Float {
		return Math.sqrt( distance2( p ));
	}

	public function closest( a:Point, b:Point ):Point {
		
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
			// The point is already on the line
			cx = this.x;
			cy = this.y;
		}

		return new Point(cx, cy);
	}
}