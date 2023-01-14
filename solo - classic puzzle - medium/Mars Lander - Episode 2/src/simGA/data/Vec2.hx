package simGA.data;

@:structInit class Vec2 {
	public static inline var EPSILON = 1e-10;
	
	public var x:Float;
	public var y:Float;

	public function toString() return 'x: $x, y: $y';
	
	public inline function distance( v:Vec2 ) return Math.sqrt(distanceSq(v));

	public inline function distanceSq( v:Vec2 ) {
		var dx = v.x - x;
		var dy = v.y - y;
		return dx * dx + dy * dy;
	}

	public inline function sub( v:Vec2 ):Vec2 return { x: x - v.x, y: y - v.y };
	public inline function add( v:Vec2 ):Vec2 return { x: x + v.x, y: y + v.y };
	public inline function multiply( v : Float ):Vec2 return { x: x * v, y: y * v };
	public inline function equals( v:Vec2 ) return x == v.x && y == v.y;
	public inline function lengthSq() return x * x + y * y;
	public inline function length() return Math.sqrt( lengthSq() );

	public inline function normalize() {
		var k = lengthSq();
		if( k < EPSILON ) k = 0 else k = 1.0 / Math.sqrt( k );
		x *= k;
		y *= k;
	}

}