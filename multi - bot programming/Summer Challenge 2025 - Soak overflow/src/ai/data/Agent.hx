package ai.data;

import CodinGame.printErr;
import Std.int;
import xa3.math.Pos;

class Agent {
	
	public static final NO_AGENT = new Agent( -1, -1, Gunner, 0, 0, 0, 0 );

	public final id:Int;
	public final player:Int;
	public final type:TAgent;
	public var shotCooldown = 0;
	public final optimalRange:Int;
	public final soakingPower:Int;
	public var splashBombs = 0;
	public var wetness = 0;

	public final maxRange:Int;
	public var pos:Pos = new Pos();

	public function new( id:Int, player:Int, type:TAgent, shotCooldown:Int, optimalRange:Int, soakingPower:Int, splashBombs:Int ) {
		this.id = id;
		this.player = player;
		this.type = type;
		this.shotCooldown = shotCooldown;
		this.optimalRange = optimalRange;
		this.soakingPower = soakingPower;
		this.splashBombs = splashBombs;
		// printErr( 'new agent $id, player: $player type: $type' );
		maxRange = optimalRange * 2;
	}

	public function update( pos:Pos, cooldown:Int, splashBombs:Int, wetness:Int ) {
		this.pos = pos;
		this.shotCooldown = cooldown;
		this.splashBombs = splashBombs;
		this.wetness = wetness;
		// printErr( 'update agent $id, $x:$y, cooldown: $shotCooldown, splashBombs: $splashBombs, wetness: $wetness' );
	}

	public function info() return '${id}${getType()}💤$shotCooldown';
	public function toString() return 'id: $id';
	
	public function getType() {
		switch type {
			case Gunner: return '🔫';
			case Sniper: return '🙮';
			case Bomber: return '💣';
			case Assault: return '🗡';
			case Berserker: return '🪓';
		}
	}

	public function getSoakingPowerWithPos( other:Pos ) {
		final distance = pos.manhattanDistance( other );
		if( distance <= optimalRange ) soakingPower;
		if( distance <= maxRange ) return int( soakingPower / 2 );
		return 0;
	}

	public function canShoot() return shotCooldown == 0;
	public function canBomb() return splashBombs > 0;

	public function isInShotRangeOf( other:Agent ) return pos.manhattanDistance( other.pos ) <= other.maxRange;
	public function isInBombRangeOf( other:Agent ) return pos.manhattanDistance( other.pos ) <= 4 + 1;
}