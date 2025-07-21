package ai.data;

import CodinGame.printErr;
import xa3.math.Pos;

class Agent {
	
	public static final NO_AGENT = new Agent( -1, -1, 0, 0, 0, 0 );

	public final id:Int;
	public final player:Int;
	public var shotCooldown = 0;
	public final optimalRange:Int;
	public final soakingPower:Int;
	public var splashBombs = 0;
	public var wetness = 0;

	public var pos:Pos = new Pos();

	public function new( id:Int, player:Int, shotCooldown:Int, optimalRange:Int, soakingPower:Int, splashBombs:Int ) {
		this.id = id;
		this.player = player;
		this.shotCooldown = shotCooldown;
		this.optimalRange = optimalRange;
		this.soakingPower = soakingPower;
		this.splashBombs = splashBombs;
		printErr( 'new agent $id, player: $player optimalRange: $optimalRange' );
	}

	public function update( pos:Pos, cooldown:Int, splashBombs:Int, wetness:Int ) {
		this.pos = pos;
		this.shotCooldown = cooldown;
		this.splashBombs = splashBombs;
		this.wetness = wetness;
		// printErr( 'update agent $id, $x:$y, cooldown: $shotCooldown, splashBombs: $splashBombs, wetness: $wetness' );
	}

	public function toString() return 'id: $id';

}