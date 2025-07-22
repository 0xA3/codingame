package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;
import ya.Set;

class Ai2 {

	public var aiId = "Ai2";
	final outputs:Array<String> = [];
	
	var allAgents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var oppAgents:Array<Agent> = [];
	var oppAgentsMap:Map<Int,Agent> = [];

	var defaultOppIdForAgent:Map<Agent, Int> = [];

	var turn = 1;

	public function new() { }

	public function setGlobalInputs( agents:Map<Int, ai.data.Agent>, board:Board ) {
		this.allAgents = agents;
		this.board = board;
	}

	public function setInputs( myAgentIds:Set<Int>, oppAgentIds:Set<Int> ) {
		myAgents  = [for( id in myAgentIds.toArray() ) allAgents[id]];
		oppAgents = [for( id in oppAgentIds.toArray() ) allAgents[id]];
		oppAgentsMap = [for( id in oppAgentIds.toArray() ) id => allAgents[id]];
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		if( turn == 1) processStart();

		for( agent in myAgents ) {
			final actions = processAgent( agent );
			outputs.push( '${agent.id}; ' + actions.map( action -> Action.toString( action )).join( "; " ) );
		}
		
		turn++;
		return outputs.join( "\n" );
	}

	function processStart() {
		myAgents.sort(( a, b ) -> a.pos.y - b.pos.y );
		oppAgents.sort(( a, b ) -> a.pos.y - b.pos.y );

		for( i in 0...myAgents.length ) {
			final myAgent = myAgents[i];
			final oppAgent = oppAgents[i];
			defaultOppIdForAgent.set( myAgent, oppAgent.id );
		}
	}

	function processAgent( agent:Agent ) {
		if( oppAgents.length == 0 ) return [TAction.HunkerDown];
		
		final actions = [];
		oppAgents.sort(( a, b ) -> sortByDistanceAndWetness( agent, a, b ));
		final closestOppAgent = oppAgents[0];

		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final targetAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;

		final targetOppDistance = agent.pos.manhattanDistance( targetAgent.pos );
		final minShootDistance = agent.optimalRange * 2;
		final isInRange = targetOppDistance <= minShootDistance;
		final canShoot = agent.shotCooldown == 0;


		if( targetOppDistance > 1 ) {
			actions.push( TAction.Move( targetAgent.pos.x, targetAgent.pos.y ));
		}

		if( isInRange && canShoot ) {
			actions.push( TAction.Shoot( targetAgent.id ));
		} else {
			actions.push( TAction.HunkerDown );
		}
		actions.push( TAction.Message( '${agent.getType()} to ${targetAgent.id}' ));
		
		return actions;
	}

	function sortByDistanceAndWetness( agent:Agent, oppA:Agent, oppB:Agent ) {
		final distanceA = agent.pos.manhattanDistance( oppA.pos );
		final distanceB = agent.pos.manhattanDistance( oppB.pos );
		if( distanceA < distanceB ) return -1;
		if( distanceA > distanceB ) return 1;

		return oppA.wetness - oppB.wetness;
	}
}