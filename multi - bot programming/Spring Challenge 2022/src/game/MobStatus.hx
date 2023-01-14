package game;

class MobStatus {
	
	var state:Int;
	var target:Player;
	var turns:Int;

	public static final WANDERING = 0;
	public static final ATTACKING = 1;

    static final YOU = 1;
    static final ENEMY = 2;
    static final NEITHER = 0;

	public function new( state:Int, target:Player, turns:Int ) {
		this.state = state;
		this.target = target;
		this.turns = turns;
	}

	public function toStringFor( player:Player ) {
		final isNearBase = state;
		final targetFor = target == null ? NEITHER
						: target == player ? YOU : ENEMY;
		
		return '$isNearBase $targetFor';
	}

	public function toString() {
		return 'state: $state target: ${target == null ? "null" : Std.string( target.index )}, turns $turns';
	}
}