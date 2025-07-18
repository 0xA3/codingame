package ai.data;

import CodinGame.printErr;
import xa3.math.Pos;

class Agent {
	
	public final agentId:Int;
	public final player:Int;
	public var shotCooldown = 0;
	public final optimalRange:Int;
	public final soakingPower:Int;
	public var splashBombs = 0;
	public var wetness = 0;

	public final pos:Pos = new Pos();

	public function new( agentId:Int, player:Int, shotCooldown:Int, optimalRange:Int, soakingPower:Int, splashBombs:Int ) {
		this.agentId = agentId;
		this.player = player;
		this.shotCooldown = shotCooldown;
		this.optimalRange = optimalRange;
		this.soakingPower = soakingPower;
		this.splashBombs = splashBombs;
		// printErr( 'new agent $agentId, player: $player' );
	}

	public function update( x:Int, y:Int, cooldown:Int, splashBombs:Int, wetness:Int ) {
		this.pos.x = x;
		this.pos.y = y;
		this.shotCooldown = cooldown;
		this.splashBombs = splashBombs;
		this.wetness = wetness;
		// printErr( 'update agent $agentId, $x:$y, cooldown: $shotCooldown, splashBombs: $splashBombs, wetness: $wetness' );
	}

	public function toString() return 'agentId: $agentId';

}