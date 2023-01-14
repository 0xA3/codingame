package csb;

class Unit extends Point {

	public var id:Int;
	public var r:Float;
	public var vx:Float;
	public var vy:Float;

	public function new( id:Int, x:Float, y:Float, r:Float, vx:Float, vy:Float ) {
		
		super( x, y );
		this.id = id;
		this.r = r;
		this.vx = vx;
		this.vy = vy;
	}

	public function collision( u:Unit ):Collision {
		return null;
	}

	public function bounce( u:Unit ) {

	}
}