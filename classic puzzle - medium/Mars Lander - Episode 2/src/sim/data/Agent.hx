package sim.data;

import Math.abs;
import Math.cos;
import Math.min;
import Math.round;
import Math.sin;
import Std.int;
import TestCases;
import sim.data.SurfaceCoords;

class Agent {
	
	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static inline var gravity = -3.711;
	
	final testCase:TestCase;
	final surfaceCoords:SurfaceCoords;

	public var x( default,null ) = 0;
	public var y( default,null ) = 0;
	public var hSpeed( default,null ) = 0;
	public var vSpeed( default,null ) = 0;
	public var fuel( default, null ) = 0;
	public var rotate( default, null ) = 0;
	public var power( default, null ) = 0;
	public var isLandedSim = false;
	public var isLanded = false;
	public var isExploded = false;
	public var isLost = false;

	var velX = 0.0;
	var velY = 0.0;
	// var prevX = 0;
	// var prevY = 0;
	var endDistance = 1;

	public function new( testCase:TestCase, surfaceCoords:SurfaceCoords ) {
		this.testCase = testCase;
		this.surfaceCoords = surfaceCoords;
		reset();
	}

	public function reset() {
		x = testCase.x;
		y = testCase.y;
		hSpeed = testCase.hSpeed;
		vSpeed = testCase.vSpeed;
		fuel = testCase.fuel;
		rotate = testCase.angle;
		hSpeed = 0;
		isExploded = false;
		isLanded = false;
		isLost = false;
		power = 0;
		// prevX = startX;
		// prevY = startY;
		rotate = 0;
		velX = 0;
		velY = 0;
		vSpeed = 0;
	}

	public function update( inRotate:Int, inPower:Int ) {
		if( isLost || isExploded || isLanded ) return;
		
		// prevX = x;
		// prevY = y;

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
		hSpeed = round( velX );
		vSpeed = round( velY );

		isLost = checkLost();
		isLandedSim = checkLandedSim();
		isLanded = checkLanded();
		if( !isLanded ) isExploded = checkExploded();
	}

	public function calcFitness() {
		final hitFraction = surfaceCoords.getHitFraction( x, y );
		final aVelH = abs( velX );
		final aVelV = abs( velY );
		final hFraction = hitFraction < 1 ? 0.1 : aVelH < 20 ? 1 : 10 / aVelH;
		final vFraction = hitFraction < 1 ? 0.1 : aVelV < 40 ? 1 : 20 / aVelV;
		// trace( 'hitFraction $hitFraction, velX $velX, hFraction $hFraction, velY $velY, vFraction $vFraction' );
		return hitFraction * hFraction * vFraction;
	}

	inline function checkLost() return x >= MAX_X || x < 0 || y >= MAX_Y;

	inline function checkLandedSim() {
		if( x >= surfaceCoords.landX1 &&
			x <= surfaceCoords.landX2 &&
			y <= surfaceCoords.landY &&
			abs( hSpeed ) <= 20 &&
			vSpeed >= -40 ) {
				y = surfaceCoords.landY;
				power = 0;
				return true;
		} else
			return false;
	}

	inline function checkLanded() return isLandedSim && rotate == 0;

	function checkExploded() {
		for( i in 1...surfaceCoords.coords.length ) {
			final x1 = surfaceCoords.coords[i - 1].x;
			final x2 = surfaceCoords.coords[i].x;
			if( x1 < x && x2 >= x ) {
				final xFraction = ( x - x1 ) / ( x2 - x1 );
				final y1 = surfaceCoords.coords[i - 1].y;
				final y2 = surfaceCoords.coords[i].y;
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