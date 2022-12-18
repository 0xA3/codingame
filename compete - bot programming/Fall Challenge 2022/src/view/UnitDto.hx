package view;

import game.Coord;

class UnitDto {
	
	public var coord:Coord;
	public var strength:Int;

	public function new( coord:Coord, strength:Int ) {
		this.coord = coord;
		this.strength = strength;
	}
}