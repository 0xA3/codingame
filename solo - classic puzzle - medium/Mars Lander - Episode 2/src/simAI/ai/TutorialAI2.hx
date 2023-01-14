package simAI.ai;

import Math.abs;
import Math.round;
import ga.Gene;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;
import simGA.data.Vec2;
import xa3.MathUtils.clamp;
import xa3.MathUtils.fclamp;
import xa3.MathUtils.rad2deg;
import xa3.MathUtils.sign;

// adapted from https://www.youtube.com/watch?v=856j5IipFfk

class TutorialAI2 extends AI {
	
	static inline var FAR_DISTANCE = 2000;
	
	var desiredDirection:Int;
	var isMovingToDesiredDirection:Bool;
	final desiredInitialSpeed:Int;

	override public function new( agent:Agent, surfaceCoords:SurfaceCoords ) {
		super( agent, surfaceCoords );
		
		final desiredDirection = sign( surfaceCoords.landX - agent.x );
		final currentDirection = sign( agent.hSpeed );
		desiredInitialSpeed = desiredDirection == currentDirection ? round( abs( agent.hSpeed )) : 100;
	}
	
	override function process():Gene {
		var outputThrust = 4;
		var outputAngle = 0.0;

		desiredDirection = sign( surfaceCoords.landX - agent.x );
		final currentDirection = sign( agent.hSpeed );
		isMovingToDesiredDirection = desiredDirection == currentDirection;
		final isOverLandingArea = agent.x >= surfaceCoords.landX1 && agent.x <= surfaceCoords.landX2;
		final isMovingUp = agent.vSpeed > 0;
		final isFar = abs( surfaceCoords.landX - agent.x ) > FAR_DISTANCE;

		if( isOverLandingArea ) {
			final landingSpeedIsOk = agent.vSpeed > -Agent.MAX_VSPEED + 1;
			if( landingSpeedIsOk && round( agent.hSpeed ) == 0 ) outputThrust = 3;
			outputAngle = getDesiredAngle( 0, 33, outputThrust );
		} else {
			if( isMovingUp ) outputThrust = 3;
			if( isFar )	outputAngle = getDesiredAngle( desiredInitialSpeed, 60, outputThrust );
			else outputAngle = getDesiredAngle( 20, 45, outputThrust );
		}
		gene.rotate = round( outputAngle );
		gene.power = outputThrust;
		
		return gene;
	}

	inline function getDesiredAngle( desiredSpeedX:Int, maxAngle:Int, outputThrust:Int ) {
		final desiredVelocity = desiredSpeedX * desiredDirection;
		final desiredAcceleration = agent.hSpeed - desiredVelocity;
		final idealAngle = getExactAngle( desiredAcceleration, outputThrust );
		
		return fclamp( idealAngle, -maxAngle, maxAngle );
	}

	inline function getAngleApproximation( desiredAcceleration:Float, maxAngle:Int ) {
		return desiredAcceleration * 2;
	}

	inline function getExactAngle( desiredAcceleration:Float, outputThrust:Int ) {
		final achievableAcceleration = fclamp( desiredAcceleration, -outputThrust, outputThrust );
		final desiredSine = achievableAcceleration / outputThrust;
		final angleRad = Math.asin( desiredSine );
		return angleRad / Math.PI * 180;
		// return rad2deg( angleRad );
	}
}