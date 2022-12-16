package game;

class CoordTuple {
	
	public final a:Coord;
	public final b:Coord;

	public function new( a:Coord, b:Coord ) {
		this.a = a;
		this.b = b;		
	}

	public function hashCode() {
		final prime = 577;
		var result = 1;
		result = prime * result + a.hashCode();
		result = prime * result + b.hashCode();
		return result;
	}
	
	public function equals( other:CoordTuple ) {
		return hashCode() == other.hashCode();
	}
}