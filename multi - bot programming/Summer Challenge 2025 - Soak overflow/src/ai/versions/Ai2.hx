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
	final showMessage = false;
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
		
		final minShootDistance = agent.optimalRange * 2;
		final canShoot = agent.shotCooldown == 0;
		
		final targetAgent = getTargetAgent( agent );
		final targetDistance = agent.pos.manhattanDistance( targetAgent.pos );

		final targetAgentMinShootDistance = targetAgent.optimalRange;
		final isInOppRange = agent.pos.manhattanDistance( targetAgent.pos ) <= targetAgentMinShootDistance;
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
		oppAgents.sort(( a, b ) -> sortOppAgents( agent, a, b ));
		var closestOppAgent = oppAgents[0];
		for( oppAgent in oppAgents ) {
			if( board.coverPositionSet.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) closestOppAgent;
		}
		
		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final defaultOppAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;
		final targetAgent = board.coverPositionSet.getCoverValue( defaultOppAgent.pos, agent.pos ) == 1 ? defaultOppAgent : closestOppAgent;

		return targetAgent;
	}
	
	function sortOppAgents( agent:Agent, oppA:Agent, oppB:Agent ) {
		final distanceA = board.getDistance( agent.pos, oppA.pos );
		final distanceB = board.getDistance( agent.pos, oppB.pos );
		if( distanceA < distanceB ) return -1;
		if( distanceA > distanceB ) return 1;

		return oppA.wetness - oppB.wetness;
	}

	function approach( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		actions.push( TAction.Move( nextPos.x, nextPos.y ));
		if( showMessage ) actions.push( TAction.Message( '${agent.getType()} approach ${targetAgent.id}' ));
	}

	function evade( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
		final neighborCells = board.getNeighborCells( agent.pos );
		final maxDistanceIndex = [for( cell in neighborCells ) cell.pos.manhattanDistance( targetAgent.pos )].maxIndex();
		final cell = neighborCells[maxDistanceIndex];
		actions.push( TAction.Move( cell.pos.x, cell.pos.y ));
		if( showMessage ) actions.push( TAction.Message( '${agent.getType()} evade ${targetAgent.id}' ));
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
		if( showMessage ) actions.push( TAction.Message( '${agent.getType()} attack ${targetAgent.id}' ));
	}

	// function throw( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
	// 	final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
	// 	actions.push( TAction.Move( nextPos.x, nextPos.y ));

	// 	final afterMoveDistance = nextPos.manhattanDistance( targetAgent.pos );
		
	// }

	function getThrowPosition( agent:Agent, targetAgent:Agent ) {
		if( agent.pos.chebyshevDistance( targetAgent.pos ) > 1 ) return targetAgent.pos;
		final neighbors = board.getNeighborCells( targetAgent.pos );
		neighbors.sort(( a, b ) -> agent.pos.chebyshevDistance( b.pos ) - agent.pos.chebyshevDistance( a.pos ));
		
		return neighbors[0].pos;
	}

}