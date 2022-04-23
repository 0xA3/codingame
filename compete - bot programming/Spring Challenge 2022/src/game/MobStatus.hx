package game;

class MobStatus {
	
	var turns:Int;
	var target:Player;
	var state:Int;

    static final YOU = 1;
    static final ENEMY = 2;
    static final NEITHER = 0;

	public function new( state:Int, target:Player, turns:Int ) {
		this.state = state;
		this.target = target;
		this.state = state;
	}

	public function toStringFor( player:Player ) return '$state ${target == null ? NEITHER : (target == player ? YOU : ENEMY)}';
}