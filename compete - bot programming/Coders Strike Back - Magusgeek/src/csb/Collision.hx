package csb;

class Collision {
	
	public var a:Unit;
	public var b:Unit;
	public var t:Float;

	public function new( a:Unit, b:Unit, t:Float ) {
		this.a = a;
		this.b = b;
		this.t = t;
	}
}