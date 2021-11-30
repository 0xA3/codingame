package simAI.ai;

import Math.PI;
import Math.abs;
import Math.atan;
import Math.round;
import ga.Gene;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;
import simGA.data.Vec2;

class AI1 extends AI {
	
	final destination:Vec2;
	
	override public function new( agent:Agent, surfaceCoords:SurfaceCoords ) {
		super( agent, surfaceCoords );
		destination = { x: surfaceCoords.landX, y: surfaceCoords.landY };
	}
	
	override function process():Gene {
		
		final vel:Vec2 = { x: agent.hSpeed, y: agent.vSpeed == 0 ? Agent.GRAVITY : agent.vSpeed };
		final direction:Vec2 = { x: destination.x - agent.x, y: destination.y - agent.y };
		final xFactor = abs( Agent.MAX_HSPEED / direction.x );
		final yFactor = abs( Agent.MAX_VSPEED / direction.y );
		final multiplier = xFactor < yFactor ? xFactor : yFactor;

		final destVel = direction.multiply( multiplier );

		final correctionVel = destVel.sub( vel );
		final fAngle = atan( correctionVel.y / correctionVel.x );
		final angle = round( fAngle * 180 / PI );

		trace( 'vel: $vel, destVel: $destVel, correctionVel: $correctionVel, rotate: ${agent.rotate}, angle: $angle' );

		gene.rotate = angle - agent.rotate;
		gene.power = 4;

		return gene;

		// return super.process(agent);
	}
}