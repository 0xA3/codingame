package game;

import game.action.Action;

class Hero extends GameEntity {
	
	final index:Int;
	public final owner:Player;
	public var rotation:Float;
	public var intent:Action;
	public var message = "";

	public function new( index:Int, position:Vector, owner:Player, rotation:Float, ?id:Int ) {
		super( position, owner.index, id );
		this.index = index;
		this.owner = owner;
		this.rotation = rotation;
		this.intent = Action.IDLE;
		// trace( 'new Hero ${this.id}' );
	}

	public function toString() {
		return 'pos: ${position.x}:${position.y}';
	}

	public function copyToPlayer( player:Player ) {
		final hero = new Hero( index, position, player, rotation, id );
		return hero;
	}
}