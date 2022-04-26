package game;

import game.action.Action;

class Hero extends GameEntity {
	
	public final index:Int;
	public final owner:Player;
	public var rotation:Float;
	public var intent:Action;
	public var message = "";

	public function new( id:Int, index:Int, position:Vector, owner:Player, rotation:Float ) {
		super( id, position, owner.index );
		this.index = index;
		this.owner = owner;
		this.rotation = rotation;
		this.intent = Action.IDLE;
		// trace( 'new Hero ${this.id}' );
	}

	override function getOwner() return owner;

	public function toString() {
		return 'pos: ${position.x}:${position.y}';
	}
}