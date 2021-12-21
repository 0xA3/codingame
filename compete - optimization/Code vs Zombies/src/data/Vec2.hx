package data;

@:structInit class Vec2 {
	public final x:Int;
	public final y:Int;

	public var angle( get, never):Float;
	public function get_angle() return Math.atan( x / y );

	public inline function add( v:Vec2 ):Vec2 {
		return { x: x + v.x, y: y + v.y };
	}
	
	public inline function sub( v:Vec2 ):Vec2 {
		return { x: x - v.x, y: y - v.y };
	}

}