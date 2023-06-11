package game.action;

abstract class Action {
	
	final type:ActionType;

	function new( type:ActionType ) {
		this.type = type;
	}

	public function getType() return type;
}