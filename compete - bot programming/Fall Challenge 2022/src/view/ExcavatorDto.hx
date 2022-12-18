package view;

import game.Coord;

class ExcavatorDto {
	
	public final coord:Coord;
	public final ownerIdx:Int;

	public function new( coord:Coord, ownerIdx:Int ) {
		this.coord = coord;
		this.ownerIdx = ownerIdx;
	}
}