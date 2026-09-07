package ai.data;

import xa3.math.Pos;

class Cell {
	
	public final pos:Pos;
	public final regionId:Int;
	public final type:TTerrain;
	
	public final neighbors:Array<Cell> = [];
	
	public function new( pos:Pos, regionId:Int, type:TTerrain ) {
		this.pos = pos;
		this.regionId = regionId;
		this.type = type;
	}

	public function addNeighbor( cell:Cell ) neighbors.push( cell );
}