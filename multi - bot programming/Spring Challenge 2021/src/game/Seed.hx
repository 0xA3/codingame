package game;

class Seed {
	
	public final owner:Int;
	public final sourceCell:Int;
	public final targetCell:Int;

	public function new( owner:Int, sourceCell:Int, targetCell:Int ) {
		this.owner = owner;
		this.sourceCell = sourceCell;
		this.targetCell = targetCell;
	}
}