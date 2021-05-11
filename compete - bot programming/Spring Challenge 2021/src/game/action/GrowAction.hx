package game.action;

class GrowAction extends Action {
	
	public function new( targetId:Int ) {
		super();
		this.targetId = targetId;
	}
	
	override function isGrow() return true;
	
	override function toString():String {
		return 'GROW $targetId';
	}
}