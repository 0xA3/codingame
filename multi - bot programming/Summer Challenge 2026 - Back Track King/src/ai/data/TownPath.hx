package ai.data;

class TownPath {
	
	public final start:Int;
	public final end:Int;
	public final cells:Array<Cell>;
	public var length:Int;

	public function new( start:Int, end:Int, cells:Array<Cell>, length:Int ) {
		this.start = start;
		this.end = end;
		this.cells = cells;
		this.length = length;
	}
}