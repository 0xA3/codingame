package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;
import ya.Set;

class AiWait {

	public var aiId = "AiWait";
	final outputs:Array<String> = [];
	
	var allAgents:Map<Int, ai.data.Agent> = [];
	var agents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var oppAgents:Array<Agent> = [];

	var turn = 1;

	public function new() { }

	public function setGlobalInputs( agents:Map<Int, ai.data.Agent>, board:Board ) {
		this.agents = agents;
		this.board = board;
	}

	public function setInputs( myAgentIds:Set<Int>, oppAgentIds:Set<Int> ) {
		myAgents  = [for( id in myAgentIds.toArray() ) allAgents[id]];
		oppAgents = [for( id in oppAgentIds.toArray() ) allAgents[id]];
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		return "Wait";
	}
}