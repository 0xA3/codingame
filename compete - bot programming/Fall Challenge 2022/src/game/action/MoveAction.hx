package game.action;

import game.Coord;

@:structInit class MoveAction {
	public final amount:Int;
	public final from:Coord;
	public final to:Coord;

	public function toString() return 'MoveAction amount: $amount, from: $from, to: $to';
}