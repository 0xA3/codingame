package ai.data;

import xa3.math.Pos;

class Board {
	
	public final width:Int;
	public final height:Int;
	public final positions:Array<Array<Pos>>;
	public final cells:Map<Pos, Cell>;
	public final tiles:Map<Pos, Int>;
	public final coverPositionSet:CoverPositionSet;

	public function new(
		width:Int,
		height:Int,
		positions:Array<Array<Pos>>,
		cells:Map<Pos, Cell>,
		tiles:Map<Pos, Int>,
		coverPositionSet:CoverPositionSet
	) {
		this.width = width;
		this.height = height;
		this.positions = positions;
		this.cells = cells;
		this.tiles = tiles;
		this.coverPositionSet = coverPositionSet;
	}
}