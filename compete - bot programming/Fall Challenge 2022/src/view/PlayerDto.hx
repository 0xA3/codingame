package view;

import game.Player;

class PlayerDto {
	
	public final money:Int;
	public final ownedCells:Int;
	public final warpCooldown:Int;
	public final message:String;

	public function new( player:Player, ownedCells:Int ) {
		money = player.money;
		this.ownedCells = ownedCells;
		warpCooldown = player.warpCooldown;
		message = player.message;
	}
}