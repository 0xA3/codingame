package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.CoverPositionSet;
import ai.data.TAction;
import xa3.math.IntMath.max;
import xa3.math.IntMath.min;
import xa3.math.Pos;
import ya.Set;

using Lambda;

class SplashBombs {
	
	public var aiId = "SplashBombs";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var width = 0;
	var height = 0;
	var positions = [];
	var tiles:Map<Pos, Int> = [];
	var coverPositionSet:CoverPositionSet;
	
	var myAgentIds:Array<Int> = [];
	var oppAgentIds:Array<Int> = [];

	public function new() { }
	
	public function setGlobalInputs( agents:Map<Int, ai.data.Agent>, width:Int, height:Int, positions:Array<Array<Pos>>, tiles:Map<Pos, Int>, coverPositionSet:CoverPositionSet ) {
		this.agents = agents;
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.tiles = tiles;
		this.coverPositionSet = coverPositionSet;
	}
	
	public function setInputs( myAgentIds:Array<Int>, oppAgentIds:Array<Int> ) {
		this.myAgentIds = myAgentIds;
		this.oppAgentIds = oppAgentIds;
	}

	public function process() {
		outputs.splice( 0, outputs.length );
		
		final positions1D = [for( y in 0...height ) for( x in 0...width ) positions[y][x]];
		final oppAgents = [for( oppAgentId in oppAgentIds ) agents[oppAgentId]];
		final oppAgentsPositions:Set<Pos> = [for( oppAgentId in oppAgentIds ) agents[oppAgentId].pos];
		
		for( i in 0...myAgentIds.length ) {
			final agentActions = [];
			final id = myAgentIds[i];
			final agent = agents[id];
			final freeNeighbors = getFreeNeighborPositions( agent.pos );
			
			final neighborsWithOpponents = freeNeighbors.filter(( pos ) -> oppAgentsPositions.contains( pos ));
			if( neighborsWithOpponents.length > 0 ) {
				final action = TAction.HunkerDown;
				agentActions.push( action );
			} else {
				final clusterCenterPos = findOppClusterCenter( positions1D, oppAgentsPositions );
				final distance = agent.pos.manhattanDistance( clusterCenterPos );
				if( distance > 4 ) {
					final action = TAction.Move( clusterCenterPos.x, clusterCenterPos.y );
					agentActions.push( action );
				} else {
					final action = TAction.Throw( clusterCenterPos.x, clusterCenterPos.y );
					agentActions.push( action );
				}
			}
			
			if( agentActions.length == 0 ) continue;
				
			outputs.push( '$id;' + agentActions.map( action -> Action.toString( action )).join( ";" ) );
		}
		
		return outputs.join( "\n" );
	}

	function findOppClusterCenter( positions:Array<Pos>, oppAgentsPositions:Set<Pos> ) {
		final oppPositionsNeighborsNum = [];
		
		for( pos in positions ) {
			final neighbors = getNeighborPositions( pos );
			
			var sum = 0;
			for( neighbor in neighbors ) {
				if( oppAgentsPositions.contains( neighbor )) sum += 1;
			}

			oppPositionsNeighborsNum.push({ pos: pos, sum: sum });
		}

		oppPositionsNeighborsNum.sort( ( a, b ) -> b.sum - a.sum );

		// for( oppAgentsNeighbor in oppAgentsNeighborsNum ) {
		// 	printErr( '${oppAgentsNeighbor.agent.pos}, sum: ${oppAgentsNeighbor.sum}' );
		// }

		return oppPositionsNeighborsNum[0].pos;
	}

	function getFreeNeighborPositions( pos:Pos ) {
		final neighbors = getNeighborPositions( pos );
		return neighbors.filter(( pos ) -> tiles[pos] == 0 );
	}
	
	function getNeighborPositions( pos:Pos ) {
		final neighbors = [];
		for( y in max( 0, pos.y - 1 )...min( height, pos.y + 2 ) ) {
			for( x in max( 0, pos.x - 1 )...min( width, pos.x + 2 ) ) {
				final neighbor = positions[y][x];
				if( neighbor != pos ) neighbors.push( neighbor );
			}
		}

		return neighbors;
	}
}
