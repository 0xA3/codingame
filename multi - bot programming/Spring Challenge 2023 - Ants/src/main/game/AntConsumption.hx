package main.game;

@:structInit class AntConsumption {
	
	public final player:Player;
	public final amount:Int;
	public final cell:Cell;
	public final path:Array<Cell>;

	public function toString() return 'player: ${player.getIndex()}, amount: $amount';
}