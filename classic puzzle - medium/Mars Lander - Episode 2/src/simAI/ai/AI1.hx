package simAI.ai;

import Math.abs;
import Math.round;
import ga.Gene;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;
import simGA.data.Vec2;
import xa3.MathUtils.clamp;
import xa3.MathUtils.deg2Rad;
import xa3.MathUtils.fclamp;
import xa3.MathUtils.lerp;
import xa3.MathUtils.sign;

class AI1 extends AI {
	
	var maxXSpeed = 80;
	static inline var MIN_OFFSET = 200;
	static inline var MAX_DISTANCE = 1000;

	var counter = 0;

	override public function new( agent:Agent, surfaceCoords:SurfaceCoords ) {
		super( agent, surfaceCoords );
		if( surfaceCoords.landY > 1800 ) maxXSpeed = 50;
	}
	
	override function process():Gene {
		
		final direction = getDirection();
		final isOverLandingArea = agent.x > surfaceCoords.landX1 && agent.x < surfaceCoords.landX2;
		final minYSpeed = isOverLandingArea ? -30 : 0;
		final maxAngle = isOverLandingArea ? 45 : 60;
		final xDistance = agent.x < surfaceCoords.landX1 ? surfaceCoords.landX1 - agent.x
					: agent.x > surfaceCoords.landX2 ? agent.x - surfaceCoords.landX2
					: 0;
		final distanceFraction = ( xDistance + MIN_OFFSET ) / MAX_DISTANCE;
		final clampedDistanceFraction = fclamp( distanceFraction, 0, 1 );
		final desiredSpeed = xDistance == 0 ? 0 : lerp( 0, maxXSpeed, clampedDistanceFraction );
		final desiredXVelocity = direction * desiredSpeed;
		
		final desiredAcceleration = agent.hSpeed - desiredXVelocity;
		final angle = fclamp( desiredAcceleration, -maxAngle, maxAngle );
		
		final isInLandingDistance = agent.y + agent.vSpeed <= surfaceCoords.landY;

		final yAccel = yAccel( angle, Agent.MAX_POWER );
		gene.rotate = isInLandingDistance ? 0 : round( angle );
		gene.power = agent.vSpeed + yAccel < minYSpeed ? 4 : 3;

		// trace( '${counter++} xDistance $xDistance, speed ${agent.hSpeed}, desiredXVelocity $desiredXVelocity' );

		return gene;
	}

	inline function getDirection() return surfaceCoords.landX > agent.x ? 1 : -1;
	inline function getCurrentDirection() return sign( agent.hSpeed );
	inline function yAccel( angle:Float, power:Int ) return Math.cos( deg2Rad( angle )) * power + Agent.GRAVITY;
	
	
}