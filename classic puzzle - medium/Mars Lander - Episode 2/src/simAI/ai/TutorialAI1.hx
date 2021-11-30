package simAI.ai;

import Math.abs;
import Math.round;
import ga.Gene;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;
import simGA.data.Vec2;
import xa3.MathUtils.fclamp;
import xa3.MathUtils.sign;

// adapted from https://www.youtube.com/watch?v=856j5IipFfk

class TutorialAI1 extends AI {
	
	static inline var FAR_DISTANCE = 2000;
	
	final destination:Vec2;
	var desiredDirection:Int;
	var isMovingToDesiredDirection:Bool;
	final desiredInitialSpeed:Int;

	override public function new( agent:Agent, surfaceCoords:SurfaceCoords ) {
		super( agent, surfaceCoords );
		destination = { x: surfaceCoords.landX, y: surfaceCoords.landY };
		
		final desiredDirection = sign( surfaceCoords.landX - agent.x );
		final currentDirection = sign( agent.hSpeed );
		desiredInitialSpeed = desiredDirection == currentDirection ? round( abs( agent.hSpeed )) : 100;
	}
	
	override function process():Gene {
		var outputTrust = 4;
		var outputAngle = 0.0;

		desiredDirection = sign( surfaceCoords.landX - agent.x );
		final currentDirection = sign( agent.hSpeed );
		isMovingToDesiredDirection = desiredDirection == currentDirection;
		final isOverLandingArea = agent.x >= surfaceCoords.landX1 && agent.x <= surfaceCoords.landX2;
		final isMovingUp = agent.vSpeed > 0;
		final isFar = abs( surfaceCoords.landX - agent.x ) > FAR_DISTANCE;

		if( isOverLandingArea ) {
			final landingSpeedIsOk = agent.vSpeed > -Agent.MAX_VSPEED + 1;
			if( landingSpeedIsOk && round( agent.hSpeed ) == 0 ) outputTrust = 3;
			outputAngle = getDesiredAngle( 0, 33 );
		} else {
			if( isMovingUp ) outputTrust = 3;
			if( isFar )	outputAngle = getDesiredAngle( desiredInitialSpeed, 60 );
			else outputAngle = getDesiredAngle( 20, 45 );
		}
		gene.rotate = round( outputAngle ) - agent.rotate;
		gene.power = outputTrust - agent.power;
		
		return gene;
	}

	function getDesiredAngle( desiredSpeedX:Int, maxAngle:Int ) {
		final desiredVelocity = desiredSpeedX * desiredDirection;
		final desiredAcceleration = agent.hSpeed - desiredVelocity;
		
		return fclamp( desiredAcceleration * 2, -maxAngle, maxAngle );
	}
}