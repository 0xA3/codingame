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

		final targetAgent = getTargetAgent( agent );
		final targetDistance = agent.pos.manhattanDistance( targetAgent.pos );

		final targetAgentMinShootDistance = targetAgent.optimalRange;
		final isInOppRange = agent.pos.manhattanDistance( targetAgent.pos ) <= targetAgentMinShootDistance;
		
		final actions = [];
		switch agent.type {
			case Sniper: getSniperActions( actions, index, agent );
			
			default:
				// if( agent.canBomb() && targetAgent.isInBombRange( agent ) ) bomb( actions, index, agent, targetAgent );
				if( agent.canShoot() ) shoot( actions, index, agent, targetAgent );
				else if( isInOppRange ) evade( actions, index, agent, targetAgent );
				else approach( actions, index, agent, targetAgent);
		}

		return actions;
	}

	function getSniperActions( actions:Array<TAction>, index:Int, agent:Agent ) {
		final isStartOfGame = turn < board.halfWidth;

		final coverPositionSums = [];
		for( coverPosition in board.coverPositions.keys() ) {
			final coverDistance = agent.pos.manhattanDistance( coverPosition );
			final coverIsOnMySide = startDirection == -1 ? coverPosition.x < board.center.x : coverPosition.x > board.center.x;
			if( isStartOfGame && !coverIsOnMySide ) continue;

			final closestOppAgentWithBombs = getClosestOppAgentWithBombs( coverPosition );
			final oppDistance = agent.pos.manhattanDistance( closestOppAgentWithBombs.pos );
			final isBombable = closestOppAgentWithBombs == Agent.NO_AGENT ? false : oppDistance < 6;
			if( isBombable ) continue;
			
			final coverSum = board.getCoverSum( coverPosition, oppAgents.map( agent -> agent.pos ) );
			if( coverSum < oppAgents.length ) {
				coverPositionSums.push({ pos: coverPosition, sum: coverSum });
				// printErr( 'cover: $coverPosition opp: ${closestOppAgentWithBombs.pos} dist $oppDistance isSafeFromBombs: $isBombable' );
			}
		}
		
		coverPositionSums.sort(( a, b ) -> {
			if( a.sum < b.sum ) return 1;
			if( a.sum > b.sum ) return -1;
			return board.centerDistance( a.pos ) - board.centerDistance( b.pos ); // keep agent close to center
		});
		// for( pos in coverPositionSums ) printErr( 'cover ${pos.pos} ${pos.sum}   dist ${board.centerDistance( pos.pos )}' );
		
		// move action
		if( coverPositionSums.length > 0 ) {
			actions.push( TAction.Move( coverPositionSums[0].pos.x, coverPositionSums[0].pos.y ));
			final nextPos = board.getNextPos( agent.pos, coverPositionSums[0].pos );
			agent.pos = nextPos;
			#if sim
			if( canMove( index, nextPos )) actions.push( TAction.Message( '${agent.info()} hide at ${coverPositionSums[0].pos}' ));
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

		// combat action
		if( agent.canShoot()) {
			final targetAgent = getClosestWettestOppAgent( agent );
			if( agent.pos.manhattanDistance( targetAgent.pos ) <= agent.maxRange ) {
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

	function getClosestWettestOppAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceRangeAndWetness( agent, a, b ));
		// for( oppAgent in oppAgents ) printErr( '${oppAgent.id} distance ${agent.pos.manhattanDistance( oppAgent.pos )} wetness ${oppAgent.wetness} p ${agent.getSoakingPowerWithPos( oppAgent.pos )}' );
		for( oppAgent in oppAgents ) if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) return oppAgent;
		
		return oppAgents[0];
	}

	function getClosestOppAgentWithBombs( pos:Pos ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceAndWetness( pos, a, b ));
		for( oppAgent in oppAgents ) if( oppAgent.canBomb() ) return oppAgent;

		return Agent.NO_AGENT;
	}

	function getTargetAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppsByDistanceAndWetness( agent.pos, a, b ));
		var closestOppAgent = oppAgents[0];
		for( oppAgent in oppAgents ) if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) closestOppAgent;
		
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

		return oppB.wetness - oppA.wetness;
	}

	function sortOppsByDistanceRangeAndWetness( agent:Agent, oppA:Agent, oppB:Agent ) {
		final soakingPowerToA = agent.getSoakingPowerWithPos( oppA.pos );
		final soakingPowerToB = agent.getSoakingPowerWithPos( oppB.pos );
		if( soakingPowerToA < soakingPowerToB ) return 1;
		if( soakingPowerToA > soakingPowerToB ) return -1;

		return oppB.wetness - oppA.wetness;
	}

	function shoot( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		agent.pos = nextPos;
		if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));

		if( targetAgent.isInBombRange( agent ) && agent.canBomb() ) {
			// printErr( '${agent.id} at pos ${agent.pos} trow' );
			final throwPosition = getThrowPosition( agent.pos, targetAgent.pos );
			actions.push( TAction.Throw( throwPosition.x, throwPosition.y ));
		
		} else if( targetAgent.isInShotRange( agent ) && agent.canShoot() ) {
			actions.push( TAction.Shoot( targetAgent.id ));
		
		} else {
			actions.push( TAction.HunkerDown );
		}
		
		#if sim
		actions.push( TAction.Message( '${agent.info()} attack ${targetAgent.id}' ));
		#end
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

	function canMove( index:Int, pos:Pos ) {
		for( i in 0...index ) if( myAgents[i].pos == pos ) return false;
		return true;
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
