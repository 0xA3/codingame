package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;

class Ai2 {

	public var aiId = "Ai2";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var oppAgents:Array<Agent> = [];

	var turn = 1;

	final agentYs:Map<Int, Int> = [];

	public function new() { }

	public function setGlobalInputs( agents:Map<Int, ai.data.Agent>, board:Board ) {
		this.agents = agents;
		this.board = board;
	}

	public function setInputs( myAgentIds:Array<Int>, oppAgentIds:Array<Int> ) {
		myAgents  = [for( id in myAgentIds ) agents[id]];
		oppAgents = [for( id in oppAgentIds ) agents[id]];

		outputs.splice( 0, outputs.length );
	}

	public function process() {
		if( turn == 1) processStart();

		final agentOppTuples = findClosestOpps( myAgents, oppAgents );
		for( agentOppTuple in agentOppTuples ) {
			final agent = agentOppTuple.agent;
			final actions = processAgent( agent, agentOppTuple.opp );
			outputs.push( '${agent.id}; ' + actions.map( action -> Action.toString( action )).join( "; " ) );
		}
		
		turn++;
		return outputs.join( "\n" );
	}

	function processStart() {
		final boardDivision = board.height / myAgents.length;
		final half = boardDivision / 2;
		myAgents.sort(( a, b ) -> a.pos.y - b.pos.y );
		for( i in 0...myAgents.length ) {
			final agent = myAgents[i];
			agentYs.set( agent.id, int( boardDivision * i + half ));
		}
	}

	function findClosestOpps( agents:Array<Agent>, oppAgents:Array<Agent> ) {
		final agentsAndOpps = [];
		for( agent in agents ) {
			final oppsAndDistances = [];
			for( oppAgent in oppAgents ) {
				final distance = agent.pos.manhattanDistance( oppAgent.pos );
				oppsAndDistances.push({ agent: oppAgent, distance: distance });
			}
			oppsAndDistances.sort(( a, b ) -> a.distance - b.distance );
			agentsAndOpps.push({ agent: agent, closestOpps: oppsAndDistances });
		}
		
		agentsAndOpps.sort(( a, b ) -> a.closestOpps[0].distance - b.closestOpps[0].distance );

		final agentOppTuples:Array<{ agent:Agent, opp:Agent }> = [];
		for( i in 0...agents.length ) {
			final agent = agentsAndOpps[i].agent;
			final closestOpps = agentsAndOpps[i].closestOpps;
			if( closestOpps.length > 0 ) {
				final closestOpp = agentsAndOpps[i].closestOpps[0];
				agentOppTuples.push({ agent: agent, opp: closestOpp.agent });
				for( o in i + 1...agents.length ) {
					final oppDistances = agentsAndOpps[o].closestOpps;
					for( oppDistance in oppDistances ) {
						if( oppDistance.agent.id == closestOpp.agent.id ) {
							oppDistances.remove( oppDistance );
							break;
						}
					}
				}
			} else {
				oppAgents.sort(( a, b ) -> agent.pos.manhattanDistance( a.pos ) - agent.pos.manhattanDistance( b.pos ));
				final closestOpp = oppAgents[0];
				agentOppTuples.push({ agent: agent, opp: closestOpp });
			}
		}

		return agentOppTuples;
	}

	function processAgent( agent:Agent, oppAgent:Agent ) {
		final actions = [];

		final closestOppDistance = agent.pos.manhattanDistance( oppAgent.pos );
		final minShootDistance = agent.optimalRange * 2;
		final isInRange = closestOppDistance <= minShootDistance;
		final canShoot = agent.shotCooldown == 0;

		if( closestOppDistance > 1 ) {
			actions.push( TAction.Move( oppAgent.pos.x, oppAgent.pos.y ));
		}

		if( isInRange && canShoot ) {
			actions.push( TAction.Shoot( oppAgent.id ));
		} else {
			actions.push( TAction.HunkerDown );
		}
		actions.push( TAction.Message( '${oppAgent.pos.x}:${oppAgent.pos.y}' ));
		
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