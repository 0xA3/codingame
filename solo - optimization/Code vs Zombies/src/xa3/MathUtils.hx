package xa3;

class MathUtils {
	
	public static inline function angle( x:Int, y:Int ) {
		return -Math.atan2( x, y );
	}
	
	public static inline function degToRad( v:Float ) return v / 180 * Math.PI;
	public static inline function radToDeg( v:Float ) return v / Math.PI * 180;

	public static inline function distance( x1:Int, y1:Int, x2:Int, y2:Int ) {
		return Math.sqrt( distanceSq( x1, y1, x2, y2 ));
	}
	
	public static inline function distanceSq( x1:Int, y1:Int, x2:Int, y2:Int ) {
		var dx = x2 - x1;
		var dy = y2 - y1;
		return dx * dx + dy * dy;
	}
	
	public static inline function lengthSq( x:Int, y:Int ) return x * x + y * y;
	public static inline function length( x:Int, y:Int ) return Math.sqrt( lengthSq( x, y ));
	
}
