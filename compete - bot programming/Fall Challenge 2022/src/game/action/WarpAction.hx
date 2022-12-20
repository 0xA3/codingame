package game.action;

import game.Coord;

@:structInit class WarpAction {
	public final amount:Int;
	public final from:Coord;
	public final to:Coord;

	public function toString() return 'WarpAction amount: $amount, from: $from, to: $to';
}