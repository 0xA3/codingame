function dist( x1:Int, y1:Int, x2:Int, y2:Int ) return Math.sqrt( dist2( x1, y1, x2, y2 ));
function dist2( x1:Int, y1:Int, x2:Int, y2:Int ) {
	final dx = x2 - x1;
	final dy = y2 - y1;
	return dx * dx + dy * dy;
}
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;