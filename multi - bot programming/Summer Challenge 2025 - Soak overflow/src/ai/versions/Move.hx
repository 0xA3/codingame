package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.data.TAction;
import xa3.math.Pos;

using Lambda;

class Move {
	
	public var aiId = "Move";
	final outputs:Array<String> = [];
	
	var agents:Map<Int, ai.data.Agent> = [];
	var myAgentIds:Array<Int> = [];

	final positions = [
		new Pos( 6, 1 ),
		new Pos( 6, 3 )
	];

	public function new() { }
	
	public function setGlobalInputs( agents:Map<Int, ai.data.Agent> ) {
		this.agents = agents;
	}
	
	public function setInputs( myAgentIds:Array<Int> ) {
		this.myAgentIds = myAgentIds;
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		for( i in 0...myAgentIds.length ) {
			final id = myAgentIds[i];
			final pos = positions[i];
			final action = TAction.Move( pos.x, pos.y );
			outputs.push( '$id;${Action.toString( action )}' );
		}
		
		return outputs.join( "\n" );
	}
}
