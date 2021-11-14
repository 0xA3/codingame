package sim.data;

import Math.abs;
import Math.cos;
import Math.round;
import Math.sin;
import TestCases;
import sim.data.SurfaceCoords;
import xa3.MathUtils.lineIntersect;
import xa3.MathUtils.max;
import xa3.MathUtils.min;
import xa3.MathUtils.segmentIntersect;

class Agent {
	
	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	static inline var gravity = -3.711;
	
	final testCase:TestCase;
	final surfaceCoords:SurfaceCoords;

	public var x( default,null ) = 0;
	public var y( default,null ) = 0;
	var prevX = 0;
	var prevY = 0;
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
	var prevVelX = 0.0;
	var prevVelY = 0.0;
	var endDistance = 1;
	final vIntersect:Vec2 = { x: 0, y: 0 };

	public function new( testCase:TestCase, surfaceCoords:SurfaceCoords ) {
		this.testCase = testCase;
		this.surfaceCoords = surfaceCoords;
		reset();
	}

	public function reset() {
		x = prevX = testCase.x;
		y = prevY = testCase.y;
		prevX = x;
		prevY = y;
		hSpeed = testCase.hSpeed;
		vSpeed = testCase.vSpeed;
		velX = prevVelX = hSpeed;
		velY = prevVelY = vSpeed;
		fuel = testCase.fuel;
		rotate = testCase.angle;
		power = testCase.power;

		isExploded = false;
		isLanded = false;
		isLost = false;
	}

	public function update( inRotate:Int, inPower:Int ) {
		if( isLost || isExploded || isLanded ) return;
		
		prevVelX = velX;
		prevVelY = velX;
		prevX = x;
		prevY = y;

		final deltaRot = inRotate - rotate;
		rotate = max( -90, min( 90, deltaRot > 15 ? rotate + 15 : deltaRot < -15 ? rotate - 15 : inRotate ));
		final deltaPower = inPower - power;
		final tempPower = deltaPower > 0 ? power + 1 : deltaPower < 0 ? power - 1 : power;
		power = min( fuel, tempPower );
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
		final hitFitness = surfaceCoords.getHitFitness( prevX, prevY, x, y );
		final aVelH = abs( velX );//Math.max( abs( velX ), abs( prevVelX ));
		final aVelV = abs( velY );//Math.max( abs( velY ), abs( prevVelY ));
		final hFraction = hitFitness < 1 ? 0.1 : aVelH < 20 ? 1 : 10 / aVelH;
		final vFraction = hitFitness < 1 ? 0.1 : aVelV < 40 ? 1 : 20 / aVelV;
		// trace( 'hitFitness $hitFitness, velX $velX, hFraction $hFraction, velY $velY, vFraction $vFraction' );
		return hitFitness * hFraction * vFraction;
		// return hitFitness;
	}

	inline function checkLost() return x >= MAX_X || x < 0 || y >= MAX_Y;

	inline function checkLandedSim() {
		if( x >= surfaceCoords.landX1 + 50 &&
			x <= surfaceCoords.landX2 - 50 &&
			y <= surfaceCoords.landY &&
			abs( hSpeed ) <= 20 &&
			vSpeed >= -40 ) {
				lineIntersect( prevX, prevY, x, y, surfaceCoords.landX1, surfaceCoords.landY, surfaceCoords.landX2, surfaceCoords.landY, vIntersect );
				x = round( vIntersect.x );
				y = round( vIntersect.y );
				power = 0;
				return true;
		} else
			return false;
	}

	inline function checkLanded() return isLandedSim && rotate == 0;

	function checkExploded() {
		final coords = surfaceCoords.coords;
		for( i in 1...coords.length ) {
			final x2 = coords[i - 1].x;
			final y2 = coords[i - 1].y;
			final x3 = coords[i].x;
			final y3 = coords[i].y;
			
			final isIntersection = segmentIntersect( prevX, prevY, x, y, x2, y2, x3, y3, vIntersect );
			if( isIntersection ) {
				x = round( vIntersect.x );
				y = round( vIntersect.y );
				return true;
			}
		}
		return false;
	}
}