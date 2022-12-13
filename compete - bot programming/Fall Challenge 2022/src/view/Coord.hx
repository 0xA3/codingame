package view;

import game.Vector;

class Coord {
	
	public var x:Int;
	public var y:Int;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function isEqual( other:Coord ) return x == other.x && y == other.y;
	
	public function toString() return '($x,$y)';

	public function toVector() return new Vector( x, y );
	
}