package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.TAction;
import xa3.math.Pos;

using Lambda;

class TakeCover {
	
	public var aiId = "TakeCover";
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
		// for( oppAgent in oppAgents ) printErr( 'agent ${oppAgent.agentId} wetness: ${oppAgent.wetness}' );
		final wettestAgent = oppAgents[0];

		for( i in 0...myAgentIds.length ) {
			final agentId = myAgentIds[i];
			final action = TAction.Shoot( wettestAgent.agentId );
			outputs.push( '$agentId;${Action.toString( action )}' );
		}
		
		return outputs.join( "\n" );
	}
}
