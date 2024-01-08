package game.action;

import game.Coord;

@:structInit class SpawnAction {
	public final amount:Int;
	public final pos:Coord;

	public function toString() return 'SpawnAction amount: $amount, pos: $pos';
}