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

class Ai3 {

	public var aiId = "Ai3";
	final showMessage = true;
	final outputs:Array<String> = [];
	
	var allAgents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var oppAgents:Array<Agent> = [];
	var oppAgentsMap:Map<Int,Agent> = [];

	var defaultOppIdForAgent:Map<Agent, Int> = [];

	var turn = 1;
	var startDirection = 0;
	final coverPositions = [];

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
		startDirection = myAgents[0].pos.x < board.center.x ? -1 : 1;
		final oppositeX = startDirection == -1 ? board.width - 1 : 0;
		
		for( coverPosition => coverValues in board.coverPositions ) {
			final y = coverPosition.y;
			if( board.getCoverValue( coverPosition, board.positions[y][oppositeX] ) < 1 ) {
				final isOnMySide = ( startDirection == -1 && coverPosition.x < board.center.x ) || ( startDirection == 1 && coverPosition.x > board.center.x );
				// printErr( 'coverPosition: $coverPosition value: ${board.getCoverValue( coverPosition, board.positions[y][oppositeX] )} isOnMySide: $isOnMySide' );
				if( isOnMySide ) coverPositions.push( coverPosition );
			}
		}
		// coverPositions.sort(( a, b ) -> board.centerDistance( a ) - board.centerDistance( b ));
		
		// final p = [for( pos in coverPositions ) '$pos'].join( ',' );
		// printErr( 'coverPositions: $p' );

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
		
		final minShootDistance = agent.optimalRange * 2;
		final canShoot = agent.shotCooldown == 0;
		
		final targetAgent = getTargetAgent( agent );
		final targetDistance = agent.pos.manhattanDistance( targetAgent.pos );

		final targetAgentMinShootDistance = targetAgent.optimalRange;
		final isInOppRange = agent.pos.manhattanDistance( targetAgent.pos ) <= targetAgentMinShootDistance;
		
		final actions = [];
		switch agent.type {
			case Sniper: getSniperActions( actions, agent, minShootDistance );
			
			default:
				if( canShoot ) shoot( actions, agent, targetAgent, minShootDistance, canShoot );
				else if( isInOppRange ) evade( actions, agent, targetAgent );
				else approach( actions, agent, targetAgent);
		}

		return actions;
	}

	function getSniperActions( actions:Array<TAction>, agent:Agent, minShootDistance:Int ) {
		coverPositions.sort(( a, b ) -> board.getDistance( agent.pos, a ) - board.centerDistance( agent.pos ));
		
		if( coverPositions.length > 0 ) {
			agent.pos = coverPositions[0];
			actions.push( TAction.Move( coverPositions[0].x, coverPositions[0].y ));
		}
		if( agent.canShoot()) {
			final targetAgent = getClosestOppAgent( agent );
			if( agent.pos.manhattanDistance( targetAgent.pos ) <= minShootDistance ) {
				actions.push( TAction.Shoot( targetAgent.id ));
				if( showMessage ) actions.push( TAction.Message( '${agent.id}${agent.getType()} shoot ${targetAgent.id}' ));
			}
		} else {
			actions.push( TAction.HunkerDown );
		}
	}

	function getClosestOppAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppAgents( agent, a, b ));
		for( oppAgent in oppAgents ) {
			if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) return oppAgent;
		}
		
		return oppAgents[0];
	}

	function getTargetAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppAgents( agent, a, b ));
		var closestOppAgent = oppAgents[0];
		for( oppAgent in oppAgents ) {
			if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) closestOppAgent;
		}
		
		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final defaultOppAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;
		final targetAgent = board.getCoverValue( defaultOppAgent.pos, agent.pos ) == 1 ? defaultOppAgent : closestOppAgent;

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
		agent.pos = nextPos;
		actions.push( TAction.Move( nextPos.x, nextPos.y ));
		if( showMessage ) actions.push( TAction.Message( '${agent.id}${agent.getType()} approach ${targetAgent.id}' ));
	}

	function evade( actions:Array<TAction>, agent:Agent, targetAgent:Agent ) {
		final neighborCells = board.getNeighborCells( agent.pos );
		final maxDistanceIndex = [for( cell in neighborCells ) cell.pos.manhattanDistance( targetAgent.pos )].maxIndex();
		final cell = neighborCells[maxDistanceIndex];
		actions.push( TAction.Move( cell.pos.x, cell.pos.y ));
		if( showMessage ) actions.push( TAction.Message( '${agent.id}${agent.getType()} evade ${targetAgent.id}' ));
	}

	function shoot( actions:Array<TAction>, agent:Agent, targetAgent:Agent, minShootDistance:Int, canShoot:Bool ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		agent.pos = nextPos;
		actions.push( TAction.Move( nextPos.x, nextPos.y ));

		final afterMoveDistance = nextPos.manhattanDistance( targetAgent.pos );
		final hasBomb = agent.splashBombs > 0;
		final isInBombRange = afterMoveDistance <= 4 + 1;
		final isInRange = afterMoveDistance <= minShootDistance;

		if( isInBombRange && hasBomb ) {
			// printErr( '${agent.id} at pos ${agent.pos} trow' );
			final throwPosition = getThrowPosition( agent.pos, targetAgent.pos );
			actions.push( TAction.Throw( throwPosition.x, throwPosition.y ));
		} else if( isInRange && canShoot ) {
			actions.push( TAction.Shoot( targetAgent.id ));
		} else {
			actions.push( TAction.HunkerDown );
		}
		if( showMessage ) actions.push( TAction.Message( '${agent.id}${agent.getType()} attack ${targetAgent.id}' ));
	}

	function getThrowPosition( myPos:Pos, targetAgentPos:Pos ) {
		var bestTrowPosition = targetAgentPos;
		var maxOppsForPosition = 0;
		for( throwY in targetAgentPos.y - 1...targetAgentPos.y + 2 ) {
			for( throwX in targetAgentPos.x - 1...targetAgentPos.x + 2 ) {
				if( board.checkOutsideBoard( throwX, throwY ) ) continue;
				final pos = board.positions[throwY][throwX];
				if( myPos.manhattanDistance( pos ) > 4 ) continue;
				final oppAgentsInBlastArea = checkBlastArea( throwX, throwY );
				// printErr( 'pos: $pos opps: $oppAgentsInBlastArea' );
				if( oppAgentsInBlastArea > maxOppsForPosition ) {
					maxOppsForPosition = oppAgentsInBlastArea;
					bestTrowPosition = pos;
				}
			}
		}

		return bestTrowPosition;
	}

	function checkBlastArea( throwX:Int, throwY:Int ) {
		var tempOppsInBlastArea = 0;
		for( blastY in throwY - 1...throwY + 2 ) {
			for( blastX in throwX - 1...throwX + 2 ) {
				if( board.checkOutsideBoard( blastX, blastY ) ) continue;
				final blastPos = board.positions[blastY][blastX];
				for( agent in myAgents ) if( agent.pos == blastPos ) tempOppsInBlastArea--;
				for( oppAgent in oppAgents ) if( oppAgent.pos == blastPos ) tempOppsInBlastArea++;
			}
		}
		return tempOppsInBlastArea;
	}

}
/*
. . . . . .
. . . . . .
. . A . . . 2,2
. . . . . .
. . . . . .
. . . . . .
*/