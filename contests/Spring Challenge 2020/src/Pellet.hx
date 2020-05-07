class Pellet {
	
	public final x:Int;
	public final y:Int;
	final value:Int;
	final distance:Float;
	
	public function new( x:Int, y:Int, value:Int, distance:Float ) {
		this.x = x;
		this.y = y;
		this.value = value;
		this.distance = distance;
	}

	public function toString() {
		return 'x $x y $y distance $distance';
	}

	public static function sortByDistance( p1:Pellet, p2:Pellet ) {
		if( p1.distance > p2.distance ) return 1;
		if( p1.distance < p2.distance ) return -1;
		return 0;
	}
}