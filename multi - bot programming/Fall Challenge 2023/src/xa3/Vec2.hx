package xa3;

@:structInit class Vec2 {
	public static inline var EPSILON = 1e-10;
	
	public var x:Int;
	public var y:Int;

	public function toString() return '$x:$y';
	
	public inline function distance( v:Vec2 ) return Math.sqrt(distanceSq(v));
	public inline function distanceXY( otherX:Int, otherY:Int ) return Math.sqrt(distanceSqXY( otherX, otherY ));

	public inline function distanceSq( v:Vec2 ) return distanceSqXY( v.x, v.y );
	public inline function distanceSqXY( otherX:Int, otherY:Int ) {
		var dx = otherX - x;
		var dy = otherY - y;
		return dx * dx + dy * dy;
	}

	public inline function sub( v:Vec2 ):Vec2 return { x: x - v.x, y: y - v.y };
	public inline function add( v:Vec2 ):Vec2 return { x: x + v.x, y: y + v.y };
	public inline function multiply( v : Int ):Vec2 return { x: x * v, y: y * v };
	public inline function equals( v:Vec2 ) return x == v.x && y == v.y;
	public inline function lengthSq() return x * x + y * y;
	public inline function length() return Math.sqrt( lengthSq() );
}