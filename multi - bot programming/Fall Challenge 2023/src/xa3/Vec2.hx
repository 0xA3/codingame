package xa3;

import Math.sqrt;

@:structInit class Vec2 {
	public static inline var EPSILON = 1e-10;
	
	public static final ZERO:Vec2 = { x: 0, y: 0 }

	public var x:Float;
	public var y:Float;

	public function toString() return '$x:$y';
	
	public inline function distance( v:Vec2 ) return Math.sqrt(distanceSq(v));
	public inline function distanceXY( otherX:Float, otherY:Float ) return Math.sqrt(distanceSqXY( otherX, otherY ));

	public inline function distanceSq( v:Vec2 ) return distanceSqXY( v.x, v.y );
	public inline function distanceSqXY( otherX:Float, otherY:Float ) {
		var dx = otherX - x;
		var dy = otherY - y;
		return dx * dx + dy * dy;
	}
	public inline function inRange( v:Vec2, range:Float ) return Math.sqrt(( v.x - x ) * ( v.x - x ) + ( v.y - y ) * ( v.y - y ));
	public static inline function invSqrt( f:Float ) return 1. / sqrt( f );
	public inline function isZero() return x == 0 && y == 0;

	public inline function sub( v:Vec2 ):Vec2 return { x: x - v.x, y: y - v.y };
	public inline function add( v:Vec2 ):Vec2 return { x: x + v.x, y: y + v.y };
	public inline function multiply( v : Float ):Vec2 return { x: x * v, y: y * v };
	
	public inline function normalize() {
		var k = lengthSq();
		if( k < EPSILON ) k = 0 else k = invSqrt( k );
		x *= k;
		y *= k;
	}

	public inline function equals( v:Vec2 ) return x == v.x && y == v.y;
	public inline function lengthSq() return x * x + y * y;
	public inline function length() return Math.sqrt( lengthSq() );
}