package game.action;

class Action {
	
	public var sourceId(default,null):Int;
	public var targetId(default,null):Int;

	public static final NO_ACTION = new Action();
	public function new() {}
    public function isGrow() return false;
    public function isComplete() return false;
    public function isSeed() return false;
    public function isWait() return false;

}