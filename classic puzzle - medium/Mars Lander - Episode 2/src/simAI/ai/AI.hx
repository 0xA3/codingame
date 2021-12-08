package simAI.ai;

import ga.Gene;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;

class AI {
	
	public final agent:Agent;
	final surfaceCoords:SurfaceCoords;
	final gene:Gene = { rotate: 0, power: 0 }

	public function new( agent:Agent, surfaceCoords:SurfaceCoords ) {
		this.agent = agent;
		this.surfaceCoords = surfaceCoords;
	}

	public function process() {
		return gene;
	}
}