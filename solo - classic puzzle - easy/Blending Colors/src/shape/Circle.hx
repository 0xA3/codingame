package shape;

class Circle extends Shape {

	override function pointIsOnBorder( point:Point ) {
		// trace( 'check Circle $this pointOnBorder  distance ${distanceTo( point )} ${ceil( distanceTo( point )) == s}' );
		return distance2To( point ) == s * s;
	}

	override function pointIsInside( point:Point ) {
		// trace( 'check Circle $this pointIsInside  ${distanceTo( point ) < s}' );
		return distance2To( point ) < s * s;
	}

	function distance2To( point:Point ) {
		final dx = x - point.x;
		final dy = y - point.y;
		return dx * dx + dy * dy;
	}
}