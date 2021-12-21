package xa3;

inline function distance( x1:Int, y1:Int, x2:Int, y2:Int ) {
	return Math.sqrt( distanceSq( x1, y1, x2, y2 ));
}

inline function distanceSq( x1:Int, y1:Int, x2:Int, y2:Int ) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return dx * dx + dy * dy;
}

inline function lengthSq( x:Int, y:Int ) return x * x + y * y;
inline function length( x:Int, y:Int ) return Math.sqrt( lengthSq( x, y ));

