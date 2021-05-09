package game;


class Cell {
	
	public static final NoCell:Cell = new Cell( -1, 0 );

	public var richness:Int;
	public final index:Int;
	public final isValid:Bool;

	public function new( index:Int, richness:Int ) {
		this.index = index;
		this.richness = richness;
		isValid = index == -1 ? false : true;
	}
}