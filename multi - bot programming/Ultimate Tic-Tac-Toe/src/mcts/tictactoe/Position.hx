package mcts.tictactoe;

@:structInit class Position {
	
	public static final NO_POSITION:Position = { x: -1, y: -1 };

	public final x:Int;
	public final y:Int;

	public function toString() return '$x:$y';
}