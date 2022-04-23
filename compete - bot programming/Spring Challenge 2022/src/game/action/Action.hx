package game.action;

class Action {

	public static var IDLE = new Action( ActionType.IDLE );

    public var destination:Vector;
    public var type:ActionType;
    public var target:Int;
    public var forced:Bool;
	
	public function new( type:ActionType ) {
		this.type = type;
	}

	public function toString() {
		return 'destination: $destination, type: $type, target: $target, forced: $forced';
	}

	public function isMove() return type == ActionType.MOVE;
}