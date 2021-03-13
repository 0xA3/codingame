import Math.acos;
import Math.pow;
import Math.sqrt;

class Vec2 {
	
	final x:Int;
	final y:Int;
	@:isVar public var length(get, never):Float;

	public function new( x:Int, y:Int ) {
		this.x = x;
		this.y = y;
	}

	public function get_length() return sqrt( pow( x, 2 ) + pow( y, 2 ));

	public static function dot( v1:Vec2, v2:Vec2 ) return v1.x * v2.x + v1.y * v2.y;
	public static function angle( v1:Vec2, v2:Vec2 ) return acos( dot( v1, v2 ) / ( v1.length * v2.length ));

}