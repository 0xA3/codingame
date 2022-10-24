package shape;

class Square extends Shape {
	
	override function pointIsOnBorder( point:Point ) {
		final isOnTopBorder = point.y == y && point.x >= x && point.x <= x + s;
		final isOnLeftBorder = point.x == x && point.y >= y && point.y <= y + s;
		final isOnBottomBorder = point.y == y + s && point.x >= x && point.x <= x + s;
		final isOnRightBorder = point.x == x + s && point.y >= y && point.y <= y + s;
		// trace( 'check Square $this  pointOnBorder   ${isOnTopBorder || isOnLeftBorder || isOnBottomBorder || isOnRightBorder}' );
		return isOnTopBorder || isOnLeftBorder || isOnBottomBorder || isOnRightBorder;
	}

	override function pointIsInside( point:Point ) {
		// trace( 'check Square $this  pointIsInside   ${point.x > x &&
			// point.x < x + s &&
			// point.y > y &&
			// point.y < y + s}' );
		return
		point.x > x &&
		point.x < x + s &&
		point.y > y &&
		point.y < y + s;
	}
}