package ai.versions;

import CodinGame.printErr;
import Math.round;
import Std.int;
import ai.data.Board;
import ai.data.Snakebot;
import ya.Set;

class AiWait {

	public var aiId = "AiWait";
	final outputs:Array<String> = [];
	
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var agents:Map<Int, ai.data.Snakebot> = [];
	var board:Board;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;

	public function new() { }

	public function setGlobalInputs( agents:Map<Int, ai.data.Snakebot>, board:Board ) {
		this.agents = agents;
		this.board = board;
	}

	public function setInputs( mySnakebotIds:Set<Int>, oppSnakebotIds:Set<Int> ) {
		mySnakebots  = [for( id in mySnakebotIds.toArray() ) allSnakebots[id]];
		oppSnakebots = [for( id in oppSnakebotIds.toArray() ) allSnakebots[id]];
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {
		return "Wait";
	}
}