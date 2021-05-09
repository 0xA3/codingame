package game;


class Cell {
	
	public static final NoCell:Cell = new Cell( -1 );

	public var richness:Int;
	public final index:Int;
	public final isValid:Bool;

	public function new( index:Int ) {
		this.index = index;
		isValid = index == -1 ? false : true;
	}
}