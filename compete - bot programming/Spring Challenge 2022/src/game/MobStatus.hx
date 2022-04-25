package game;

class MobStatus {
	
	var state:Int;
	var target:Player;
	var turns:Int;

    static final YOU = 1;
    static final ENEMY = 2;
    static final NEITHER = 0;

	public function new( state:Int, target:Player, turns:Int ) {
		this.state = state;
		this.target = target;
		this.turns = turns;
	}

	public function toStringFor( player:Player ) return '$state ${target == null ? NEITHER : (target == player ? YOU : ENEMY)}';
}