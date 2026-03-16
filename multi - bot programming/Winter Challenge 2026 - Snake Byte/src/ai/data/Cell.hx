package ai.data;

import xa3.math.Pos;

class Cell {
	
	public final pos:Pos;
	public final neighbors:Array<Cell> = [];
	
	public function new( pos:Pos ) {
		this.pos = pos;
	}

	public function addNeighbor( cell:Cell ) neighbors.push( cell );
}