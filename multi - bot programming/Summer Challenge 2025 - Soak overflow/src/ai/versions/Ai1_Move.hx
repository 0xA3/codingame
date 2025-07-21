package ai.versions;

import ai.contexts.Action;
import ai.data.CoverPositionSet;
import ai.data.TAction;
import xa3.math.Pos;

class Ai1_Move {

	public var aiId = "Ai1_Move";
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

		outputs.splice( 0, outputs.length );
	}

	public function process() {
		for( id in myAgentIds ) {
			final action = Action.toString( TAction.HunkerDown );
			outputs.push( Action.toString( TAction.HunkerDown ));
		}
		
		return outputs.join( "\n" );
	}
}