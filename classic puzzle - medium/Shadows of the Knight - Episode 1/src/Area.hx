class Area {
	
	public final top:Int;
	public final left:Int;
	public final right:Int;
	public final bottom:Int;
	@:isVar public var center( get, never ):Point;

	public function new( left:Int, top:Int, right:Int, bottom:Int ) {
		this.left = left;
		this.top = top;
		this.right = right;
		this.bottom = bottom;
	}

	function get_center():Point {
		return { x: left + Math.round(( right - left ) / 2 ), y: top + Math.round(( bottom - top ) / 2 ) };
	}

}

typedef Point = {
	final x:Int;
	final y:Int;
}
