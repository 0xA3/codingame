package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import xa3.math.Pos;
import ya.Set;

class AiWait {

	public var aiId = "AiWait";
	final outputs:Array<String> = [];
	
	var board:Board;
	
	var turn = 1;

	public function new() { }

	public function setGlobalInputs() {
		// this.board = board;
	}

	public function setInputs() {
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {

		turn++;

		return "Wait";
	}
}