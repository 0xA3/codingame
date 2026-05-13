package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import ai.data.Tree;
import ai.data.Troll;
import xa3.math.Pos;
import ya.Set;

class AiWait {

	public var aiId = "AiWait";
	final outputs:Array<String> = [];
	
	var board:Board;
	
	var turn = 1;

	public function new() { }

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myTrolls:Set<Int>, oppTrolls:Set<Int>, trees:Map<Pos, Tree> ) {
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {

		turn++;

		return "Wait";
	}
}