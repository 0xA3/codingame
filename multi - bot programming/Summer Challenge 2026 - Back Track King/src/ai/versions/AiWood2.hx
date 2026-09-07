package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import xa3.math.Pos;
import ya.Set;

class AiWood2 {

	public var aiId = "AiWood2";
	final outputs:Array<String> = [];
	
	var board:Board;
	
	var turn = 1;

	public function new() { }

	public function setGlobalInputs( board:Board) {
		this.board = board;
	}

	public function setInputs() {
		
		outputs.splice( 0, outputs.length );
	}

	public function process() {

		final firstTown = board.towns[0];
		final secondTown = board.towns[1];
		turn++;
		
		return 'AUTOPLACE ${firstTown.pos.x} ${firstTown.pos.y} ${secondTown.pos.x} ${secondTown.pos.y}';
	}
}