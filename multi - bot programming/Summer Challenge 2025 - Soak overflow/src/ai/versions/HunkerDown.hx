package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.TAction;

using Lambda;

class HunkerDown {
	
	public var aiId = "HunkerDown";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var myAgentIds:Array<Int> = [];

	public function new() { }
	
	public function setGlobalInputs( agents:Map<Int, ai.data.Agent> ) {
		this.agents = agents;
	}
	
	public function setInputs( myAgentIds:Array<Int> ) {
		this.myAgentIds = myAgentIds;
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		for( id in myAgentIds ) {
			final action = Action.toString( TAction.HunkerDown );
			outputs.push( Action.toString( TAction.HunkerDown ));
		}
		
		return outputs.join( "\n" );
	}
}
