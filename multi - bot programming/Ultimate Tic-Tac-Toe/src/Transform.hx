import Std.int;

class Transform {
	
	extern public static inline function getIndex( x:Int, y:Int ) {
		return int( y / 3 ) * 3 + int( x / 3 );
	}

	extern public static inline function getLocalX( x:Int ) {
		return x % 3;
	}
	
	extern public static inline function getLocalY( y:Int ) {
		return y % 3;
	}

	extern public static inline function getGlobalX( index:Int, x:Int ) {
		final xIndex = index % 3;
		return xIndex * 3 + x;
	}
	
	extern public static inline function getGlobalY( index:Int, y:Int ) {
		final yIndex = int( index / 3 );
		return yIndex * 3 + y;
	}
}