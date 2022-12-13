package gameengine.core;

class Tooltip {
	
	final player:Int;
	final message:String;

	public function new( player:Int, message:String ) {
		this.player = player;
		this.message = message;
	}
}