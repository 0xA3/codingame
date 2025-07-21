package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;

class Ai1 {

	public var aiId = "Ai1";
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

		for( agent in myAgents ) {
			final actions = processAgent( agent, oppAgents );
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

	// move agent to center
	// shoot at closest opponent
	// hunker down if in range and cannot shoot
	function processAgent( agent:Agent, oppAgents:Array<Agent> ) {
		final actions = [];
		final centerX = int( board.width / 2 );

		oppAgents.sort(( oppA, oppB ) -> sortByDistanceAndWetness( agent, oppA, oppB ));
		final closestOppAgent = oppAgents[0];
		
		final closestOppDistance = agent.pos.manhattanDistance( closestOppAgent.pos );
		final minShootDistance = agent.optimalRange * 2 + 1;
		final isInRange = closestOppDistance <= minShootDistance;
		final canShoot = agent.shotCooldown == 0;

		if( closestOppDistance > 1 ) {
			actions.push( TAction.Move( centerX, agentYs[agent.id] ));
		}

		if( isInRange && canShoot ) {
			actions.push( TAction.Shoot( closestOppAgent.id ));
		} else {
			actions.push( TAction.HunkerDown );
		}

		// actions.push( TAction.HunkerDown );
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