package sim.data;

import Math.abs;
import Math.cos;
import Math.min;
import Math.round;
import Math.sin;
import Std.int;
import sim.data.SurfaceCoords;

class Agent {
	
	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static inline var gravity = -3.711;
	
	final surfaceCoords:SurfaceCoords;

	public var x( default,null ) = 0;
	public var y( default,null ) = 0;
	public var hSpeed( default,null ) = 0;
	public var vSpeed( default,null ) = 0;
	public var fuel( default, null ) = 0;
	public var rotate( default, null ) = 0;
	public var power( default, null ) = 0;
	public var isLanded = false;
	public var isExploded = false;
	public var isLost = false;

	var velX = 0.0;
	var velY = 0.0;

	public function new( surfaceCoords:SurfaceCoords ) {
		this.surfaceCoords = surfaceCoords;
	}

	public function init( startX:Int, startY:Int, startFuel:Int ) {
		x = startX;
		y = startY;
		fuel = startFuel;
		isLanded = false;
		isExploded = false;
		isLost = false;
	}

	public function update( inRotate:Int, inPower:Int ) {
		if( isLost || isExploded || isLanded ) return;
		
		final deltaRot = inRotate - rotate;
		rotate = deltaRot > 15 ? rotate + 15 : deltaRot < -15 ? rotate - 15 : inRotate;
		
		// power = inPower;
		power = int( min( fuel, inPower ));
		fuel -= power;
		
		final fRotation = -rotate / 180 * Math.PI;
		final powerX = power * sin( fRotation );
		final powerY = power * cos( fRotation );
		final forceX = powerX;
		final forceY = gravity + powerY;
		
		velX = velX + forceX;
		velY = velY + forceY;

		x = round( x + velX );
		y = round( y + velY );

		isLost = checkLost();
		isLanded = checkLanded();
		isExploded = checkExploded();
	}

	inline function checkLost() return x >= MAX_X || x < 0 || y >= MAX_Y;

	inline function checkLanded() {
		if( x >= surfaceCoords.landX1 &&
			x <= surfaceCoords.landX2 &&
			y <= surfaceCoords.landY &&
			abs( hSpeed ) <= 20 &&
			vSpeed >= -40 &&
			rotate == 0 ) {
				y = surfaceCoords.landY;
				power = 0;
				return true;
		} else
			return false;
	}

	function checkExploded() {
		for( i in 1...surfaceCoords.coords.length ) {
			final x1 = surfaceCoords.coords[i - 1][0];
			final x2 = surfaceCoords.coords[i][0];
			if( x1 < x && x2 >= x ) {
				final xFraction = ( x - x1 ) / ( x2 - x1 );
				final y1 = surfaceCoords.coords[i - 1][1];
				final y2 = surfaceCoords.coords[i][1];
				final surfaceY = y1 + ( y2 - y1 ) * xFraction;
				if( y <= surfaceY ) {
					y = round( surfaceY );
					power = 0;
					return true;
				}
				break;
			}
		}
		return false;
	}
}