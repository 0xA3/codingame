package data;

@:structInit class Vec2 {
	public final x:Int;
	public final y:Int;

	public var angle( get, never):Float;
	public function get_angle() return -Math.atan2( x, y );

	public var length( get, never):Float;
	public function get_length() return Math.sqrt( get_lengthSq() );
	
	public var lengthSq( get, never):Float;
	public inline function get_lengthSq() return x * x + y * y;

	public inline function add( v:Vec2 ):Vec2 {
		return { x: x + v.x, y: y + v.y };
	}

	public inline function sub( v:Vec2 ):Vec2 {
		return { x: x - v.x, y: y - v.y };
	}

	public function toString() return 'x: $x, y: $y';

}