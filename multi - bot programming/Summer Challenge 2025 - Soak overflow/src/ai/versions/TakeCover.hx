package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
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
	
	public function setGlobalInputs( agents:Map<Int, ai.data.Agent>, width:Int, height:Int, positions:Array<Array<Pos>>, tiles:Map<Pos, Int> ) {
		this.agents = agents;
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.tiles = tiles;
	}
	
	public function setInputs( myAgentIds:Array<Int>, oppAgentIds:Array<Int> ) {
		this.myAgentIds = myAgentIds;
		this.oppAgentIds = oppAgentIds;
	}

	public function process() {
		outputs.splice( 0, outputs.length );
		
		final oppAgents = [for( oppAgentId in oppAgentIds ) agents[oppAgentId] ];
		oppAgents.sort(( a, b ) -> b.wetness - a.wetness );
		final wettestAgent = oppAgents[0];

		for( i in 0...myAgentIds.length ) {
			final agentActions = [];
			final agentId = myAgentIds[i];
			final agent = agents[agentId];
			final coverPositions = findCoverPositions( agent.pos, oppAgentIds.map( agentId -> agents[agentId].pos ));
			if( coverPositions.length > 0 ) {
				coverPositions.sort(( a, b ) -> b.cover - a.cover );
				final bestCover = coverPositions[0];
				final action = TAction.Move( bestCover.pos.x, bestCover.pos.y );

				agentActions.push( action );
			}
			outputs.push( '$agentId;' + agentActions.map( action -> Action.toString( action )).join( ";" ) );
		}
		
		return outputs.join( "\n" );
	}

	function findCoverPositions( agentPos:Pos, oppPositions:Array<Pos> ) {
		final neighbors = getFreeNeighborPositions( agentPos );
		printErr( 'agent at $agentPos neighbors: ' + neighbors.map( pos -> '$pos' ).join( ", " ) );

		final neighborCoverSums	= [];
		for( neighbor in neighbors ) {
			var coverSum = 0;
			for( oppPosition in oppPositions ) {
				final coverValue = getCoverValue( neighbor, oppPosition );
				coverSum += coverValue;
			}
			neighborCoverSums.push( coverSum );
		}

		final coverPositions = [];
		for( i in 0...neighbors.length ) coverPositions.push({ cover: neighborCoverSums[i], pos: neighbors[i] });

		return coverPositions;
	}

	function getCoverValue( pos:Pos, oppPosition:Pos ) {
		final boxNeighbors = getBoxNeighborPositions( pos );
		if( boxNeighbors.length == 0 ) return 0;

		for( boxNeighbor in boxNeighbors ) {
			if( boxNeighbor.x > pos.x && oppPosition.x > boxNeighbor.x + 1 ) return tiles[boxNeighbor];
			if( boxNeighbor.x < pos.x && oppPosition.x < boxNeighbor.x - 1 ) return tiles[boxNeighbor];
			if( boxNeighbor.y > pos.y && oppPosition.y > boxNeighbor.y + 1 ) return tiles[boxNeighbor];
			if( boxNeighbor.y < pos.y && oppPosition.y < boxNeighbor.y - 1 ) return tiles[boxNeighbor];
		}

		return 0;
	}
	
	function getFreeNeighborPositions( pos:Pos ) {
		final neighbors = getNeighborPositions( pos );
		return neighbors.filter(( pos ) -> tiles[pos] == 0 );
	}

	function getBoxNeighborPositions( pos:Pos ) {
		final neighbors = getNeighborPositions( pos );
		return neighbors.filter(( pos ) -> tiles[pos] > 0 );
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
