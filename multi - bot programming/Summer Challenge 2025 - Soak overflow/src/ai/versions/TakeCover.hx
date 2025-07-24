package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.Agent;
import ai.data.TAction;
import xa3.math.IntMath.max;
import xa3.math.IntMath.min;
import xa3.math.Pos;

using Lambda;

class TakeCover {
	
	public var aiId = "TakeCover";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var width = 0;
	var height = 0;
	var positions = [];
	var tiles:Map<Pos, Int> = [];
	
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
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		final oppAgents = oppAgentIds.map( id -> agents[id] );
		for( i in 0...myAgentIds.length ) {
			final agentActions = [];
			final id = myAgentIds[i];
			final agent = agents[id];
			final freeNeighbors = getFreeNeighborPositions( agent.pos );
			
			final coverPositions = findCoverPositions( agent.pos, freeNeighbors, oppAgents.map( agent -> agent.pos ) );
			coverPositions.sort(( a, b ) -> a.cover < b.cover ? -1 : 1 );
			
			final bestCoverPosition = coverPositions.length > 0 ? coverPositions[0].pos : Pos.NO_POS;
			// printErr( '${agent.pos} bestCoverPosition: $bestCoverPosition' );
			if( bestCoverPosition == Pos.NO_POS ) continue;

			final moveAction = TAction.Move( bestCoverPosition.x, bestCoverPosition.y );
			agentActions.push( moveAction );
			
			final oppAgentsInRange = oppAgents.filter( opp -> bestCoverPosition.manhattanDistance( opp.pos ) <= agent.optimalRange );
			if( oppAgentsInRange.length == 0 ) continue;

			final leastCoveredOppAgent = findLeastCoveredOppAgent( bestCoverPosition, oppAgentsInRange );
				
			final shootAction = TAction.Shoot( leastCoveredOppAgent.id );
			agentActions.push( shootAction );
			
			outputs.push( '$id;' + agentActions.map( action -> Action.toString( action )).join( ";" ) );
		}
		
		return outputs.join( "\n" );
	}

	function findCoverPositions( myPos:Pos, neighbors:Array<Pos>, oppPositions:Array<Pos> ) {
		// printErr( 'agent at $myPos neighbors: ' + neighbors.map( pos -> '$pos' ).join( ", " ) );

		final neighborCoverSums	= [];
		for( neighbor in neighbors ) {
			final coverValue = coverPositionSet.getCoverSum( neighbor, oppPositions );
			neighborCoverSums.push( coverValue );
		}

		final coverPositions = [];
		for( i in 0...neighbors.length ) coverPositions.push({ cover: neighborCoverSums[i], pos: neighbors[i] });

		return coverPositions;
	}

	function findLeastCoveredOppAgent( myPos:Pos, oppAgents:Array<Agent> ) {
		final oppAgentsCoverValues = [for( i in 0...oppAgents.length ) { oppAgent: oppAgents[i], coverValue: coverPositionSet.getCoverValue( oppAgents[i].pos, myPos )}];
		oppAgentsCoverValues.sort(( a, b ) -> a.coverValue < b.coverValue ? 1 : -1 );

		// for( oc in oppAgentsCoverValues ) printErr( '$myPos oppAgent ${oc.oppAgent.id} coverValue: ${oc.coverValue}' );

		return oppAgentsCoverValues[0].oppAgent;
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
