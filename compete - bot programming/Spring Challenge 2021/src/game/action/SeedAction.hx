package game.action;

class SeedAction extends Action {
	
	public function new( sourceId:Int, targetId:Int ) {
		super();
		this.sourceId = sourceId;
		this.targetId = targetId;
	}
	override function isSeed() return true;

	override function toString():String {
		return 'SEED from $sourceId to $targetId';
	}
}
