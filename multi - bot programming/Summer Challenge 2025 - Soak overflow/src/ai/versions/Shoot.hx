package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.TAction;

using Lambda;

class Shoot {
	
	public var aiId = "Shoot";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var myAgentIds:Array<Int> = [];
	var oppAgentIds:Array<Int> = [];

	public function new() { }
	
	public function setGlobalInputs( agents:Map<Int, ai.data.Agent> ) {
		this.agents = agents;
	}
	
	public function setInputs( myAgentIds:Array<Int>, oppAgentIds:Array<Int> ) {
		this.myAgentIds = myAgentIds;
		this.oppAgentIds = oppAgentIds;
	}

	public function process() {
		outputs.splice( 0, outputs.length );
		
		final oppAgents = [for( oppAgentId in oppAgentIds ) agents[oppAgentId] ];
		oppAgents.sort(( a, b ) -> b.wetness - a.wetness );
		// for( oppAgent in oppAgents ) printErr( 'agent ${oppAgent.id} wetness: ${oppAgent.wetness}' );
		final wettestAgent = oppAgents[0];

		for( i in 0...myAgentIds.length ) {
			final id = myAgentIds[i];
			final action = TAction.Shoot( wettestAgent.id );
			outputs.push( '$id;${Action.toString( action )}' );
		}
		
		return outputs.join( "\n" );
	}
}
