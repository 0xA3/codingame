package gameengine.core;

class Tooltip {
	
	public final player:Int;
	public final message:String;

	public function new( player:Int, message:String ) {
		this.player = player;
		this.message = message;
	}
}