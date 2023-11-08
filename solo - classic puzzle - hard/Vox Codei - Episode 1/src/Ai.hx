import CodinGame.printErr;
import data.Pos;

class Ai {
	
	final board:Board;

	public function new( board:Board ) {
		this.board = board;
	}

	public function process( rounds:Int, bombs:Int ) {
		if( bombs == 0 ) return "WAIT";
		return placeBomb();
	}

	function placeBomb() {
		return "0 1";
	}
}