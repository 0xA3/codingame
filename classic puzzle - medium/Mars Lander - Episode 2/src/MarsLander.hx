class MarsLander {
	
	public final surface:Array<Array<Int>>;
	final landX1:Int;
	final landX2:Int;
	final landY:Int;

	public function new( surface:Array<Array<Int>> ) {
		this.surface = surface;
		for( i in 1...surface.length ) {
			final c0 = surface[i - 1];
			final c1 = surface[i];
			if( c0[1] == c1[1] ) {
				landX1 = c0[0];
				landX2 = c1[0];
				landY = c0[1];
				break;
			}
		}
	}

	public function update( x:Int, y:Int, hSpeed:Int, vSpeed:Int, fuel:Int, rotate:Int, power:Int ) {
		var rotate = 0;
		if( x < landX1 ) {
			final distance = landX1 - x;
			rotate = -1;
			if( distance > 100 ) rotate = -5;
			if( distance > 500 ) rotate = -12;
			if( distance > 1000 ) rotate = -18;
		} else if( x > landX2 ) {
			final distance = x - landX2;
			rotate = 1;
			if( distance > 100 ) rotate = 5;
			if( distance > 500 ) rotate = 12;
			if( distance > 1000 ) rotate = 18;
		} else {
			if( hSpeed > 5 ) rotate = 3;
			if( hSpeed > 15 ) rotate = 12;
			if( hSpeed > 20 ) rotate = 18;
			if( hSpeed < -5 ) rotate = -3;
			if( hSpeed < -15 ) rotate = -12;
			if( hSpeed < -20 ) rotate = -18;
		}	

		if( y + vSpeed * 2 <= landY ) {
			// trace( 'y $y  landY $landY  y + vSpeed ${y + vSpeed}' );
			rotate = 0;
		}
		// final dPower = vSpeed >= 0 ? 0 : vSpeed <= -15 ? Math.min( 4, power + 1 ) : power;
		var dPower = 0;
		if( vSpeed <= -20 ) dPower = 4;
		// final rotate = 0;
		// final dPower = 0;
		return '$rotate $dPower';
	}
}