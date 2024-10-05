package data;

import Math.sqrt;

class Point {
	
	public final x:Int;
	public final y:Int;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function equals( other:Point ) {
		if( this == other ) return true;
		return this.x == other.x && this.y == other.y;
	}

	public function toString() return '$x:$y';

	public function distanceTo( other:Point ) return distance( this, other );

	public static function distance( p1:Point, p2:Point ) return sqrt( distanceSq( p1, p2 ) );

	public static function distanceSq( p1:Point, p2:Point ) {
		final dx = p1.x - p2.x;
		final dy = p1.y - p2.y;
		return dx * dx + dy * dy;
	}

	public static function pointOnSegment( p1:Point, p2:Point, p3:Point) {
		final epsilon = 0.0000001;
		final dist = distance( p2, p1 ) + distance( p1, p3 ) - distance( p2, p3 );
		return -epsilon < dist && dist < epsilon;
	}

}