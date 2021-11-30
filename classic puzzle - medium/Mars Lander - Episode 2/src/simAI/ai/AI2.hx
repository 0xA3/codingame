package simAI.ai;

import Math.abs;
import ga.Gene;
import simGA.data.Agent;
import simGA.data.Vec2;
import xa3.MathUtils.lineIntersect;

class AI2 extends AI {
	
	final pos:Vec2 = { x: 0, y: 0 };

	override function process():Gene {
		final dx = agent.hSpeed;
		final dy = agent.vSpeed < 0 ? agent.vSpeed : Agent.GRAVITY;
		final intersect = lineIntersect( agent.x, agent.y, agent.x + dx, agent.y + dy, surfaceCoords.landX1, surfaceCoords.landY, surfaceCoords.landX2, surfaceCoords.landY, pos );
		
		if( intersect ) {
			final distance1 = abs( pos.x - surfaceCoords.landX1 );
			final distance2 = abs( pos.x - surfaceCoords.landX2 );


			
		}
		
		trace( 'Warning: no intersection with landing platform found.' );
		return super.process();
	}
}