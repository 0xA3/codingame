package data;

class Circle {
	
	public static final NO_CIRCLE = new Circle( new Point( 0, 0 ), 0 );

	public final center:Point;
	public final radius:Int;

	public function new( center:Point, radius:Int ) {
		this.center = center;
		this.radius = radius;
	}

	public function toString() return '$center r$radius';
}