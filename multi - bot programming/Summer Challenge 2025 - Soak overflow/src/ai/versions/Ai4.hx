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

class Ai4 {

	public var aiId = "Ai4";
	final outputs:Array<String> = [];
	
	var allAgents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var oppAgents:Array<Agent> = [];
	var oppAgentsMap:Map<Int,Agent> = [];

	var defaultOppIdForAgent:Map<Agent, Int> = [];

	var turn = 1;
	var startDirection = 0;

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
		for( i in 0...myAgents.length ) {
			final agent = myAgents[i];
			final actions = processAgent( i, agent );
			outputs.push( '${agent.id}; ' + actions.map( action -> Action.toString( action )).join( "; " ) );
		}
		
		turn++;
		return outputs.join( "\n" );
	}

	function processStart() {
		startDirection = myAgents[0].pos.x < board.center.x ? -1 : 1;

		myAgents.sort(( a, b ) -> a.pos.y - b.pos.y );
		oppAgents.sort(( a, b ) -> a.pos.y - b.pos.y );

		for( i in 0...myAgents.length ) {
			final myAgent = myAgents[i];
			final oppAgent = oppAgents[i];
			defaultOppIdForAgent.set( myAgent, oppAgent.id );
		}
	}

	function processAgent( index:Int, agent:Agent ) {
		if( oppAgents.length == 0 ) return [TAction.HunkerDown];

		final minShootDistance = agent.optimalRange * 2;
		final canShoot = agent.shotCooldown == 0;
		
		final targetAgent = getTargetAgent( agent );
		final targetDistance = agent.pos.manhattanDistance( targetAgent.pos );

		final targetAgentMinShootDistance = targetAgent.optimalRange;
		final isInOppRange = agent.pos.manhattanDistance( targetAgent.pos ) <= targetAgentMinShootDistance;
		
		final actions = [];
		switch agent.type {
			case Sniper: getSniperActions( actions, index, agent, minShootDistance );
			
			default:
				if( canShoot ) shoot( actions, index, agent, targetAgent, minShootDistance, canShoot );
				else if( isInOppRange ) evade( actions, index, agent, targetAgent );
				else approach( actions, index, agent, targetAgent);
		}

		return actions;
	}

	function getSniperActions( actions:Array<TAction>, index:Int, agent:Agent, minShootDistance:Int ) {
		final coverPositionSums = [];
		for( coverPosition in board.coverPositions.keys() ) {
			final coverDistance = agent.pos.manhattanDistance( coverPosition );
			// printErr( '${agent.pos} - $coverPosition dist $coverDistance' );
			// if( coverDistance > board.width ) continue;

			final closestOppAgentWithBombs = getClosestOppAgentWithBombs( coverPosition );
			final oppDistance = agent.pos.manhattanDistance( closestOppAgentWithBombs.pos );
			final isBombable = closestOppAgentWithBombs == Agent.NO_AGENT ? false : oppDistance <= 6;
			if( isBombable ) continue;
			
			final coverSum = board.getCoverSum( coverPosition, oppAgents.map( agent -> agent.pos ) );
			if( coverSum < oppAgents.length ) {
				coverPositionSums.push({ pos: coverPosition, sum: coverSum });
				// printErr( 'cover: $coverPosition opp: ${closestOppAgentWithBombs.pos} dist $oppDistance isSafeFromBombs: $isBombable' );
			}
		}
		
		coverPositionSums.sort(( a, b ) -> {
			if( a.sum < b.sum ) return -1;
			if( a.sum > b.sum ) return 1;
			return turn < board.halfWidth
			? board.centerDistance( a.pos ) - board.centerDistance( b.pos )
			: agent.pos.manhattanDistance( a.pos ) - agent.pos.manhattanDistance( b.pos );
		});
		// printErr( turn < board.halfWidth ? 'center sort' : 'agent distance sort' );
		// final p = [for( pos in coverPositionSums ) '${pos.pos} ${pos.sum}'].join( ',' );
		// printErr( 'coverPositions: $p' );
		
		if( coverPositionSums.length > 0 ) {
			actions.push( TAction.Move( coverPositionSums[0].pos.x, coverPositionSums[0].pos.y ));
			agent.pos = coverPositionSums[0].pos;
			#if sim
			actions.push( TAction.Message( '${agent.info()} hide at ${coverPositionSums[0].pos}' ));
			#end
		} else {
			final closestOpp = getClosestOppAgentWithBombs( agent.pos );
			final cellNeighbors = board.getNeighborCells( agent.pos );
			final maxDistanceIndex = [for( cell in cellNeighbors ) cell.pos.manhattanDistance( closestOpp.pos )].maxIndex();
			final evadePos = cellNeighbors[maxDistanceIndex].pos;
			if( canMove( index, evadePos )) actions.push( TAction.Move( evadePos.x, evadePos.y ));
			#if sim
			actions.push( TAction.Message( '${agent.info()} evade ${closestOpp.id}' ));
			#end
		}

		if( agent.canShoot()) {
			final targetAgent = getClosestWettestOppAgent( agent.pos );
			if( agent.pos.manhattanDistance( targetAgent.pos ) <= minShootDistance ) {
				actions.push( TAction.Shoot( targetAgent.id ));
				#if sim
				actions.push( TAction.Message( '${agent.info()} shoot ${targetAgent.id}' ));
				#end
			}
		} else {
			actions.push( TAction.HunkerDown );
			#if sim
			actions.push( TAction.Message( '${agent.info()} wait' ));
			#end
		}
	}

	function canMove( index:Int, pos:Pos ) {
		for( i in 0...index ) if( myAgents[i].pos == pos ) return false;
		return true;
	}

	function getClosestOppAgentWithBombs( pos:Pos ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceAndWetness( pos, a, b ));
		for( oppAgent in oppAgents ) {
			if( oppAgent.hasBobs() ) return oppAgent;
		}

		return Agent.NO_AGENT;
	}

	function getClosestWettestOppAgent( pos:Pos ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceAndWetness( pos, a, b ));
		for( oppAgent in oppAgents ) {
			if( board.getCoverValue( oppAgent.pos, pos ) == 1 ) return oppAgent;
		}
		
		return oppAgents[0];
	}

	function getTargetAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceAndWetness( agent.pos, a, b ));
		var closestOppAgent = oppAgents[0];
		for( oppAgent in oppAgents ) {
			if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) closestOppAgent;
		}
		
		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final defaultOppAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;
		final targetAgent = board.getCoverValue( defaultOppAgent.pos, agent.pos ) == 1 ? defaultOppAgent : closestOppAgent;

		return targetAgent;
	}
	
	function sortOppsByDistanceAndWetness( pos:Pos, oppA:Agent, oppB:Agent ) {
		final distanceA = board.getDistance( pos, oppA.pos );
		final distanceB = board.getDistance( pos, oppB.pos );
		if( distanceA < distanceB ) return -1;
		if( distanceA > distanceB ) return 1;

		return oppA.wetness - oppB.wetness;
	}

	function approach( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		agent.pos = nextPos;
		if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));
		#if sim
		actions.push( TAction.Message( '${agent.info()} approach ${targetAgent.id}' ));
		#end
	}

	function evade( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final neighborCells = board.getNeighborCells( agent.pos );
		final maxDistanceIndex = [for( cell in neighborCells ) cell.pos.manhattanDistance( targetAgent.pos )].maxIndex();
		final cell = neighborCells[maxDistanceIndex];
		if( canMove( index, cell.pos )) actions.push( TAction.Move( cell.pos.x, cell.pos.y ));
		#if sim
		actions.push( TAction.Message( '${agent.info()} evade ${targetAgent.id}' ));
		#end
	}

	function shoot( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent, minShootDistance:Int, canShoot:Bool ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		agent.pos = nextPos;
		if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));

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
		#if sim
		actions.push( TAction.Message( '${agent.info()} attack ${targetAgent.id}' ));
		#end
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
