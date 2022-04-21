package game;

import game.action.Action;
import gameengine.core.AbstractMultiplayerPlayer;

class Player extends AbstractMultiplayerPlayer {
	
	public var name:String;
	public var message:Null<String>;
	public var action:Action;

	public var health:Int;
	public var mana:Int;
	public var heros:Array<Hero> = [];

	public function new( index:Int, herosPerPlayer:Int, ?name:String ) {
		this.index = index;
		this.name = name == null ? "Nobody" : name;
		for( _ in 0...herosPerPlayer ) heros.push( new Hero( this ) );
	}

	public function getExpectedOutputLines() return 1;
	
	public function reset() {
		message = null;
		action = Action.NO_ACTION;
	}

	public function toString() {
		return '$name index $index';
	}

}