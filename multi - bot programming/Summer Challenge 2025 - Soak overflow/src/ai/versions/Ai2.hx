package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;
import xa3.math.Pos;
import ya.Set;

using xa3.ArrayUtils;

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

		myAgents.sort(( a, b ) -> board.centerDistance( a.pos ) - board.centerDistance( b.pos ));
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
		final neighborCells = board.getNeighborCells( agent.pos );
		
		oppAgents.sort(( a, b ) -> sortByDistanceAndWetness( agent, a, b ));
		final closestOppAgent = oppAgents[0];

		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final targetAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;

		final targetDistance = agent.pos.manhattanDistance( targetAgent.pos );
		final minShootDistance = agent.optimalRange * 2;
		final canShoot = agent.shotCooldown == 0;

		final targetAgentMinShootDistance = targetAgent.optimalRange;
		final isInOppRange = agent.pos.manhattanDistance( targetAgent.pos ) <= targetAgentMinShootDistance;
		final isWetter = agent.wetness > targetAgent.wetness;
		// switch agent.type {
			// case Sniper:
				if( canShoot ) shoot( actions, agent, targetAgent, minShootDistance, canShoot );
				else if( isInOppRange ) evade( actions, agent, targetAgent );
				else approach( actions, agent, targetAgent);
			
			// default: attack( actions, agent, targetAgent, minShootDistance, canShoot );
		// }

		return actions;
	}

	function getTargetAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortByDistanceAndWetness( agent, a, b ));
		final closestOppAgent = oppAgents[0];
		
	}

	function approach( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		actions.push( TAction.Move( nextPos.x, nextPos.y ));
		actions.push( TAction.Message( '${agent.getType()} approach ${targetAgent.id}' ));
	}

	function evade( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
		final neighborCells = board.getNeighborCells( agent.pos );
		final maxDistanceIndex = [for( cell in neighborCells ) cell.pos.manhattanDistance( targetAgent.pos )].maxIndex();
		final cell = neighborCells[maxDistanceIndex];
		actions.push( TAction.Move( cell.pos.x, cell.pos.y ));
		actions.push( TAction.Message( '${agent.getType()} evade ${targetAgent.id}' ));
	}

	function shoot( actions:Array<TAction>, agent:Agent, targetAgent:Agent, minShootDistance:Int, canShoot:Bool ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		actions.push( TAction.Move( nextPos.x, nextPos.y ));

		final afterMoveDistance = nextPos.manhattanDistance( targetAgent.pos );
		final hasBomb = agent.splashBombs > 0;
		final isInBombRange = afterMoveDistance <= 4 + 1;
		final isInRange = afterMoveDistance <= minShootDistance;

		if( isInBombRange && hasBomb ) {
			final throwPosition = getThrowPosition( agent, targetAgent );
			actions.push( TAction.Throw( throwPosition.x, throwPosition.y ));
		} else if( isInRange && canShoot ) {
			actions.push( TAction.Shoot( targetAgent.id ));
		} else {
			actions.push( TAction.HunkerDown );
		}
		actions.push( TAction.Message( '${agent.getType()} attack ${targetAgent.id}' ));
	}

	// function throw( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
	// 	final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
	// 	actions.push( TAction.Move( nextPos.x, nextPos.y ));

	// 	final afterMoveDistance = nextPos.manhattanDistance( targetAgent.pos );
		
	// }

	function getThrowPosition( agent:Agent, targetAgent:Agent ) {
		return targetAgent.pos;
	}

	function sortByDistanceAndWetness( agent:Agent, oppA:Agent, oppB:Agent ) {
		final distanceA = agent.pos.manhattanDistance( oppA.pos );
		final distanceB = agent.pos.manhattanDistance( oppB.pos );
		if( distanceA < distanceB ) return -1;
		if( distanceA > distanceB ) return 1;

		return oppA.wetness - oppB.wetness;
	}
}