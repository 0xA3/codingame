package game.data;

class Board {
	
	public static inline var IN_PROGRESS = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;
	
	public final players:Array<Player>;
	public final actions:Array<Action> = [];

	var totalMoves:Int;

	public function new( players:Array<Player>, actions:Array<Action>, totalMoves = 0 ) {
		this.players = players;
		this.actions = actions;
		this.totalMoves = totalMoves;
	}

	public static function createEmpty() {
		final players = [new Player(), new Player()];
		final actions = [];
		return new Board( players, actions );
	}

	public static function fromBoard( board:Board ) {
		final players = [board.players[0].copy(), board.players[1].copy()];
		final actions = board.actions;
		return new Board( players, actions );
	}

	public function performAction( player:Int, action:Action ) {
		totalMoves++;
		
	}

	public function clearActions() {
		actions.splice(0, actions.length);
	}
	
	public function addAction( action:Action ) {
		actions.push( action );
	}

}