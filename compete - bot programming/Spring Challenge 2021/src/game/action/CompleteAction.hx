package game.action;

class CompleteAction extends Action {
	
	public function new( targetId:Int ) {
		super();
		this.targetId = targetId;
	}
	
	override function isComplete() return true;

}