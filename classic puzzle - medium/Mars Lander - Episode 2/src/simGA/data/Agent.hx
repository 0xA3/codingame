package simGA.data;

import Math.abs;
import Math.cos;
import Math.round;
import Math.sin;
import TestCases;
import simGA.data.SurfaceCoords;
import xa3.MathUtils.clamp;
import xa3.MathUtils.max;
import xa3.MathUtils.min;
import xa3.MathUtils.segmentIntersect;

class Agent {
	
	static inline var MAX_X = 7000;
	static inline var MAX_Y = 3000;
	public static inline var GRAVITY = -3.711;
	public static inline var MIN_ROTATION_ANGLE = -90;
	public static inline var MAX_ROTATION_ANGLE = 90;
	public static inline var MIN_POWER = 0;
	public static inline var MAX_POWER = 4;
	public static inline var MAX_ROTATE_STEP = 15;
	public static inline var MAX_POWER_STEP = 1;
	public static inline var MAX_HSPEED = 20;
	public static inline var MAX_VSPEED = 40;

	final testCase:TestCase;
	final surfaceCoords:SurfaceCoords;

	public var x = 0.0;
	public var y = 0.0;
	var prevX = 0.0;
	var prevY = 0.0;
	public var hSpeed = 0.0;
	public var vSpeed = 0.0;
	var prevHSpeed = 0.0;
	var prevVSpeed = 0.0;
	public var fuel( default, null ) = 0;
	public var rotate( default, null ) = 0;
	public var prevRotate = 0;
	public var power( default, null ) = 0;
	
	public var isFinished = false;
	public var isInLandingParameters = false;
	public var isLanded = false;
	public var isExploded = false;
	public var isLost = false;
	var endDistance = 1;
	final vIntersect:Vec2 = { x: 0, y: 0 };
	
	// to save rotation of every frame
	public final rotates:Array<Int>;
	public final powers:Array<Int>;
	var frame = 0;

	public function new( testCase:TestCase, surfaceCoords:SurfaceCoords, numGenes:Int ) {
		this.testCase = testCase;
		this.surfaceCoords = surfaceCoords;
		rotates = [for( _ in 0...numGenes ) 0];
		powers = [for( _ in 0...numGenes ) 0];
		reset();
	}

	public function reset() {
		x = prevX = testCase.x;
		y = prevY = testCase.y;
		prevX = x;
		prevY = y;
		hSpeed = testCase.hSpeed;
		vSpeed = testCase.vSpeed;
		prevHSpeed = hSpeed;
		prevVSpeed = vSpeed;
		fuel = testCase.fuel;
		rotate = prevRotate = testCase.angle;
		power = testCase.power;
		frame = 0;

		isFinished = false;
		isInLandingParameters = false;
		isExploded = false;
		isLanded = false;
		isLost = false;
	}

	public function update( deltaRotate:Int, deltaPower:Int ) {
		if( isFinished ) return;
		
		prevHSpeed = hSpeed;
		prevVSpeed = vSpeed;
		prevX = x;
		prevY = y;
		prevRotate = rotate;

		final clampedDeltaRotate = clamp( deltaRotate, -MAX_ROTATE_STEP, MAX_ROTATE_STEP );
		final clampedDeltaPower = clamp( deltaPower, -MAX_POWER_STEP, MAX_POWER_STEP );
		
		rotate = max( MIN_ROTATION_ANGLE, min( MAX_ROTATION_ANGLE, rotate + clampedDeltaRotate ));
		final tempPower = max( MIN_POWER, min( MAX_POWER, power + clampedDeltaPower ));
		power = min( fuel, tempPower );
		fuel -= power;
		
		final fRotation = -rotate / 180 * Math.PI;
		final powerX = power * sin( fRotation );
		final powerY = power * cos( fRotation );
		final forceX = powerX;
		final forceY = GRAVITY + powerY;
		
		hSpeed += forceX;
		vSpeed += forceY;

		x += ( prevHSpeed + hSpeed ) / 2;
		y += ( prevVSpeed + vSpeed ) / 2;
		
		rotates[frame] = rotate;
		powers[frame] = power;
		frame++;
	}

	public function checkFinishedSim() {
		if( checkLost() || checkHit()) {
			isFinished = true;
			isInLandingParameters = checkSimLandingRequirements();
		}
	}

	public function checkFinishedPlay() {
		if( checkLost()) 	{ isFinished = true; 	isLost = true; 		return; }
		if( checkLanded()) 	{ isFinished = true; 	isLanded = true; 	return; }
		if( checkHit()) 	{ isFinished = true; 	isExploded = true; 	return; }
	}

	inline function checkLost() {
		if( x < 0 ) 		{ x = 0; 		return true; }
		if( x >= MAX_X ) 	{ x = MAX_X;	return true; }
		if( y < 0 ) 		{ y = 0;		return true; }
		if( y >= MAX_Y )	{ y = MAX_Y;	return true; }
		return false;
	}

	function checkHit() {
		final coords = surfaceCoords.coords;
		for( i in 1...coords.length ) {
			final x2 = coords[i - 1].x;
			final y2 = coords[i - 1].y;
			final x3 = coords[i].x;
			final y3 = coords[i].y;
			if( segmentIntersect( prevX, prevY, x, y, x2, y2, x3, y3, vIntersect )) {
				x = vIntersect.x;
				y = vIntersect.y;
				// trace( 'checkHit intersect ${round( x )}:${round( y )}' );
				return true;
			}
		}
		return false;
	}

	inline function checkLanded() {
		if( checkSimLandingRequirements() && rotate == 0 ) {
			segmentIntersect( prevX, prevY, x, y, surfaceCoords.landX1, surfaceCoords.landY, surfaceCoords.landX2, surfaceCoords.landY, vIntersect );
			x = vIntersect.x;
			y = vIntersect.y;
			power = 0;
			return true;
		}
		return false;
	}
	
	function checkSimLandingRequirements() {
		if( x >= surfaceCoords.landX1 + 50 &&
			x <= surfaceCoords.landX2 - 50 &&
			y <= surfaceCoords.landY &&
			round( abs( hSpeed )) <= MAX_HSPEED &&
			abs( rotate ) <= MAX_ROTATE_STEP &&
			vSpeed >= -MAX_VSPEED )
		{
			return true;
		}
		return false;
	}

	public function calcFitness() {
		// return 1.0;
		final hitFitness = surfaceCoords.getHitFitness( prevX, prevY, x, y );
		final aHSpeed = Math.max( abs( hSpeed ), abs( prevHSpeed ));
		final aRotate = xa3.MathUtils.abs( prevRotate );
		final rFitness = hitFitness < 1 ? 0.1 : aRotate <= 15 ? 1 : 7 / aRotate;
		final hFitness = hitFitness < 1 ? 0.1 : aHSpeed < 20 ? 1 : 10 / aHSpeed;
		final vFitness = hitFitness < 1 ? 0.1 : vSpeed >= -40 ? 1 : 20 / abs( vSpeed );
		
		// final totalFitness = hitFitness * rFitness * hFitness * vFitness;
		// if( totalFitness == 1.0 ) {
			// trace( 'hitFitness: $hitFitness\nrFitness: $rFitness, prevRotate: $prevRotate, rotate: $rotate,\nhFitness: $hFitness, hSpeed $hSpeed\nvFitness: $vFitness, vSpeed: $vSpeed' );
		// }
		return hitFitness * rFitness * hFitness * vFitness;
	}



}