package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.Board;
import ai.data.TAction;
import xa3.math.IntMath.abs;
import xa3.math.Pos;
import ya.Set;

using xa3.ArrayUtils;

class Ai7 {

	public var aiId = "Ai7";
	final outputs:Array<String> = [];
	
	var myId:Int;
	var allAgents:Map<Int, ai.data.Agent> = [];
	var board:Board;
	
	var myAgents:Array<Agent> = [];
	var myAgentsPositions:Map<Agent, Pos> = [];
	var oppAgents:Array<Agent> = [];
	var oppAgentsMap:Map<Int,Agent> = [];

	var defaultOppIdForAgent:Map<Agent, Int> = [];

	var turn = 1;
	var startDirection = 0;
	var isGameStart = true;

	public function new() { }

	public function setGlobalInputs( myId:Int, allAgents:Map<Int, ai.data.Agent>, board:Board ) {
		this.myId = myId;
		this.allAgents = allAgents;
		this.board = board;
	}

	public function setInputs( myAgentIds:Set<Int>, oppAgentIds:Set<Int> ) {
		myAgents  = [for( id in myAgentIds.toArray() ) allAgents[id]];
		myAgentsPositions = [for( agent in myAgents ) agent => agent.pos];
		oppAgents = [for( id in oppAgentIds.toArray() ) allAgents[id]];
		oppAgentsMap = [for( id in oppAgentIds.toArray() ) id => allAgents[id]];
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		if( turn == 1 ) processStart();
		if( turn > board.thirdWidth ) isGameStart = false;
		
		printErr( '${turn}' );
		// board.calculateMyCellsNum( myAgentsPositions, oppAgents );

		if( isGameStart ) {
			myAgents.sort(( a, b ) -> abs( b.pos.y - board.center.y ) - abs( a.pos.y - board.center.y ));
		} else {
			myAgents.sort(( a, b ) -> board.centerDistance( a.pos ) - board.centerDistance( b.pos ));
		}
		// for( agent in myAgents ) printErr( 'agent ${agent.id} pos ${agent.pos} centerDistance ${abs( agent.pos.y - board.center.y)}' );

		for( i in 0...myAgents.length ) {
			final agent = myAgents[i];
			final actions = processAgent( i, agent );
			if( actions.length == 0 ) actions.push( TAction.HunkerDown );

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

		final targetAgent = isGameStart ? getStartTargetAgent( agent ) : getTargetAgent( agent );

		final actions = [];
		switch agent.type {
			case Sniper:
				setSniperMove( actions, index, agent );
				setSniperCombat( actions, index, agent );
			case Gunner:
				setGunnerMove( actions, index, agent, targetAgent );
				setGunnerCombat( actions, index, agent, targetAgent );
			default:
				if( agent.canShoot() || agent.canBomb()) {
					setMove( actions, index, agent, targetAgent );
					attack( actions, index, agent, targetAgent );
				} else {
					evade( actions, index, agent, targetAgent );
				}
		}

		return actions;
	}

	function setMove( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final neighborsOfOpp = board.getNeighborCells( targetAgent.pos );
		var maxPoints = 0;
		var bestNeighbor = Pos.NO_POS;
		for( cell in neighborsOfOpp ) {
			final points = board.calculateMyCellsNum( agent, cell.pos, myAgents, oppAgents );
			if( points > maxPoints ) {
				maxPoints = points;
				bestNeighbor = cell.pos;
			}
		}
		// printErr( '${agent.info()} opp: ${targetAgent.pos} n: ${bestNeighbor}' );

		final targetPos = bestNeighbor == Pos.NO_POS ? targetAgent.pos : bestNeighbor;
		final nextPos = board.getNextPos( agent.pos, targetPos );
		
		if( canMove( index, nextPos )) {
			agent.pos = nextPos;
			actions.push( TAction.Move( nextPos.x, nextPos.y ));
		}

		#if sim
		if( !agent.canShoot() && !agent.canBomb()) actions.push( TAction.Message( '${agent.info()} approach ${targetAgent.id}' ));
		#end
	}

	function setSniperMove( actions:Array<TAction>, index:Int, agent:Agent ) {
		final isStartOfGame = turn < board.halfWidth;

		final coverPositionSums = [];
		for( coverPosition in board.coverPositions.keys() ) {
			final coverDistance = agent.pos.manhattanDistance( coverPosition );
			final coverIsOnMySide = startDirection == -1 ? coverPosition.x < board.center.x : coverPosition.x > board.center.x;
			if( isStartOfGame && !coverIsOnMySide ) continue;

			final closestOppAgentWithBombs = getClosestOppAgentWithBombs( coverPosition );
			if( agent.isInBombRangeOf( closestOppAgentWithBombs )) continue;
			// final oppDistance = agent.pos.manhattanDistance( closestOppAgentWithBombs.pos );
			// final isBombable = closestOppAgentWithBombs == Agent.NO_AGENT ? false : oppDistance < 7;
			// if( isBombable ) continue;
			
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
			final nextPos = board.getNextPos( agent.pos, coverPositionSums[0].pos );
			if( canMove( index, nextPos )) {
				agent.pos = nextPos;
				actions.push( TAction.Move( nextPos.x, nextPos.y ));
			}
			
			#if sim
			if( canMove( index, nextPos )) actions.push( TAction.Message( '${agent.info()} hide ${coverPositionSums[0].pos}' ));
			#end
		} else {
			if( getSoakSum( agent.pos ) > 0 ) {
				final closestOpp = getClosestOppAgentWithBombs( agent.pos );
				evade( actions, index, agent, closestOpp );
			}
		}
	}

	function setSniperCombat( actions:Array<TAction>, index:Int, agent:Agent ) {
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

	// follow targetAgent
	function setGunnerMove( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final neighborsOfOpp = board.getNeighborCells( targetAgent.pos );
		var maxPoints = 0;
		var bestNeighbor = Pos.NO_POS;
		for( cell in neighborsOfOpp ) {
			final points = board.calculateMyCellsNum( agent, cell.pos, myAgents, oppAgents );
			if( points > maxPoints ) {
				maxPoints = points;
				bestNeighbor = cell.pos;
			}
		}

		final targetPos = bestNeighbor == Pos.NO_POS ? targetAgent.pos : bestNeighbor;
		final nextPos = board.getNextPos( agent.pos, targetPos );
		agent.pos = nextPos;
		if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));
		
	}

	function setGunnerCombat( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		var hasCombatAction = false;
		if( targetAgent.isInShotRangeOf( agent ) && agent.canShoot() ) {
			actions.push( TAction.Shoot( targetAgent.id ));
			hasCombatAction = true;
		}

		if( !hasCombatAction && targetAgent.isInBombRangeOf( agent ) && agent.canBomb() ) {
			// printErr( '${agent.id} at pos ${agent.pos} trow' );
			final throwPosition = getThrowPosition( agent.pos, targetAgent.pos );
			if( throwPosition != Pos.NO_POS ) {
				actions.push( TAction.Throw( throwPosition.x, throwPosition.y ));
				hasCombatAction = true;
				targetAgent.wetness += 30;
			}
		
		}

		if( !hasCombatAction ) actions.push( TAction.HunkerDown );
		
		#if sim
		actions.push( TAction.Message( '${agent.info()} attack ${targetAgent.id}' ));
		#end
	}

	function getClosestWettestOppAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppsForShoot( agent, a, b ));
		// for( oppAgent in oppAgents ) printErr( '${oppAgent.id} distance ${agent.pos.manhattanDistance( oppAgent.pos )} wetness ${oppAgent.wetness} p ${agent.getHitScore( oppAgent.pos )}' );
		
		for( oppAgent in oppAgents ) if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) return oppAgent;
		
		return oppAgents[0];
	}

	function getClosestOppAgentWithBombs( pos:Pos ) {
		oppAgents.sort(( a, b ) -> sortOppsForBombs( pos, a, b ));
		for( oppAgent in oppAgents ) if( oppAgent.canBomb() ) return oppAgent;

		return Agent.NO_AGENT;
	}

	function sortOppsForBombs( pos:Pos, oppA:Agent, oppB:Agent ) {
		if( oppA.wetness >= 100 && oppB.wetness < 100 ) return -1; // filter out dead opps
		if( oppA.wetness < 100 && oppB.wetness >= 100 ) return 1;

		final distanceA = board.getDistance( pos, oppA.pos );
		final distanceB = board.getDistance( pos, oppB.pos );
		if( distanceA < distanceB ) return -1;
		if( distanceA > distanceB ) return 1;

		return oppB.wetness - oppA.wetness;
	}

	function getStartTargetAgent( agent:Agent ) {
		final defaultOppAgentId = defaultOppIdForAgent[agent];
		if( oppAgentsMap.exists( defaultOppAgentId )) return oppAgentsMap[defaultOppAgentId];
		
		oppAgents.sort(( a, b ) -> sortOppsForShoot( agent, a, b ));
		var closestOppAgent = oppAgents[0];

		return closestOppAgent;
	}

	function getTargetAgent( agent:Agent ) {
		oppAgents.sort(( a, b ) -> sortOppsForShoot( agent, a, b ));
		var closestOppAgent = oppAgents[0];
		for( oppAgent in oppAgents ) if( board.getCoverValue( oppAgent.pos, agent.pos ) == 1 ) closestOppAgent;
		
		final defaultOppAgentId = defaultOppIdForAgent[agent];
		final defaultOppAgent = oppAgentsMap[defaultOppAgentId] ?? closestOppAgent;
		final targetAgent = board.getCoverValue( defaultOppAgent.pos, agent.pos ) == 1 ? defaultOppAgent : closestOppAgent;

		return targetAgent;
	}
	
	function sortOppsForShoot( agent:Agent, oppA:Agent, oppB:Agent ) {
		final coverForA = board.getCoverValue( oppA.pos, agent.pos );
		final coverForB = board.getCoverValue( oppA.pos, agent.pos );
		if( coverForA == 0.75 && coverForB < 0.75 ) return -1; // sort out covered opps
		if( coverForA < 0.75 && coverForB == 0.75 ) return 1;

		final hitScoreOfA = agent.getHitScore( oppA.pos );
		final hitScoreOfB = agent.getHitScore( oppB.pos );
		if( hitScoreOfA < hitScoreOfB ) return 1; // sort by hit score
		if( hitScoreOfA > hitScoreOfB ) return -1;

		return oppB.wetness - oppA.wetness;
	}

	function attack( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		// final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
		// agent.pos = nextPos;
		// if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));

		var hasCombatAction = false;
		if( targetAgent.isInBombRangeOf( agent ) && agent.canBomb() ) {
			// printErr( '${agent.id} at pos ${agent.pos} trow' );
			final throwPosition = getThrowPosition( agent.pos, targetAgent.pos );
			if( throwPosition != Pos.NO_POS ) {
				actions.push( TAction.Throw( throwPosition.x, throwPosition.y ));
				hasCombatAction = true;
				targetAgent.wetness += 30;
			}
		
		}
		if( !hasCombatAction && targetAgent.isInShotRangeOf( agent ) && agent.canShoot() ) {
			actions.push( TAction.Shoot( targetAgent.id ));
			hasCombatAction = true;
		}

		if( !hasCombatAction ) actions.push( TAction.HunkerDown );
		
		#if sim
		actions.push( TAction.Message( '${agent.info()} attack ${targetAgent.id}' ));
		#end
	}
	
	// function approach( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
	// 	final nextPos = board.getNextPos( agent.pos, targetAgent.pos );
	// 	agent.pos = nextPos;
	// 	if( canMove( index, nextPos )) actions.push( TAction.Move( nextPos.x, nextPos.y ));
		
	// 	#if sim
	// 	actions.push( TAction.Message( '${agent.info()} approach ${targetAgent.id}' ));
	// 	#end
	// }

	function evade( actions:Array<TAction>, index:Int, agent:Agent, targetAgent:Agent ) {
		final neighborPositions = [agent.pos].concat( board.getNeighborPositions( agent.pos ) );
		final positionRankings = [];
		for( pos in neighborPositions ) {
			final soakSum = getSoakSum( pos );
			final distance = pos.manhattanDistance( targetAgent.pos );
			final points = board.calculateMyCellsNum( agent, pos, myAgents, oppAgents );
			
			positionRankings.push({ pos: pos, soakSum: soakSum, distance: distance, points: points });
		}
		
		positionRankings.sort(( a, b ) -> { // a - b  1 2 > -1  2 1 -> 1
			if( a.soakSum < b.soakSum ) return -1;
			if( a.soakSum > b.soakSum ) return 1;

			if( a.points < b.points ) return 1;
			if( b.points > a.points ) return -1;
			
			return b.distance - a.distance;
		});

		// for( positionRanking in positionRankings ) {
		// 	printErr( '${agent.id} pos ${positionRanking.pos} soakSum ${positionRanking.soakSum} dist ${positionRanking.distance}  points ${positionRanking.points}' );
		// }
		final nextPos = positionRankings.length > 0 ? positionRankings[0].pos : Pos.NO_POS;

		if( canMove( index, nextPos )) {
			agent.pos = nextPos;
			actions.push( TAction.Move( nextPos.x, nextPos.y ));
		}
		
		#if sim
		actions.push( TAction.Message( '${agent.info()} evade ${targetAgent.id}' ));
		#end
	}

	function canMove( index:Int, pos:Pos ) {
		for( i in 0...index ) if( myAgents[i].pos == pos ) return false;
		return true;
	}

	function getSoakSum( pos:Pos ) {
		var soakSum = 0;
		for( oppAgent in oppAgents ) {
			final coverSum  = board.getCoverValue( pos, oppAgent.pos );
			final hitScore = oppAgent.canShoot() ? oppAgent.getHitScore( pos ) : 0;
			final bombScore = oppAgent.canBomb() ? oppAgent.getBombScore( pos ) : 0;
			soakSum += int( hitScore * ( 1 - coverSum ));
		}

		return soakSum;
	}

	function getThrowPosition( myPos:Pos, targetAgentPos:Pos ) {
		final throwPositions = [];
		
		for( oppAgent in oppAgents ) {
			final oppAgentPos = oppAgent.pos;
			for( throwY in oppAgentPos.y - 1...oppAgentPos.y + 2 ) {
				for( throwX in oppAgentPos.x - 1...oppAgentPos.x + 2 ) {
					if( board.checkOutsideBoard( throwX, throwY ) ) continue;
					final pos = board.positions[throwY][throwX];
					if( myPos.manhattanDistance( pos ) > 4 ) continue;
					final agentScoreInArea = checkBlastArea( throwX, throwY );
					// printErr( 'pos: $pos opps: $oppAgentsInBlastArea' );
					if( agentScoreInArea <= 0 ) continue;

					throwPositions.push({ pos: pos, agentScoreInArea: agentScoreInArea, isCenter: throwX == oppAgentPos.x && throwY == oppAgentPos.y });
				}
			}
		}
		if( throwPositions.length == 0 ) return Pos.NO_POS;

		throwPositions.sort( function( a, b ) { // a - b  - 1 2 3 4   =  a > b -> 1  a < b -> -1
			if( a.agentScoreInArea < b.agentScoreInArea ) return 1;
			if( a.agentScoreInArea > b.agentScoreInArea ) return -1;

			if( a.isCenter && !b.isCenter ) return -1;
			if( !a.isCenter && b.isCenter ) return 1;

			if( a.pos == targetAgentPos && b.pos != targetAgentPos ) return -1;
			if( a.pos != targetAgentPos && b.pos == targetAgentPos ) return 1;

			return 0;
		});

		for( throwPosition in throwPositions ) printErr( 'throw: ${throwPosition.pos} scrore: ${throwPosition.agentScoreInArea} isCenter: ${throwPosition.isCenter}' );
		
		return throwPositions[0].pos;
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
