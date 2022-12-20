package view;

import game.Player;

class PlayerDto {
	
	public final money:Int;
	public final warpCooldown:Int;
	public final message:String;

	public function new( player:Player ) {
		money = player.money;
		warpCooldown = player.warpCooldown;
		message = player.message;
	}
}