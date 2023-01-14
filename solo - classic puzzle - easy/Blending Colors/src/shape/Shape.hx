package shape;

class Shape {
	
	final x:Int;
	final y:Int;
	final s:Int;
	public final color:Color;

	public function new( x:Int, y:Int, s:Int, color:Color ) {
		this.x = x;
		this.y = y;
		this.s = s;
		this.color = color;
	}

	public function pointIsOnBorder( point:Point ) return false;
	public function pointIsInside( point:Point ) return false;

	public function toString() return 'x: $x, y: $y, s: $s, color: $color';
}