package board;

@:structInit class Node {
	public final parent:Null<Node>;
	public final action:String;
	public final rounds:Int;
	public final bombsNum:Int;
	public final board:Board;

	public function toString() return 'rounds $rounds, bombsNum $bombsNum';
}
