typedef Edge = {
	final from:Int;
	final to:Int;
	final cost:Float;
}

class Path {
	
	public final length:Float;
	public final edges:Array<Edge>;

	public function new( edges:Array<Edge>, length:Float ) {
		this.length = length;
		this.edges = edges;
	}

	public function toString() {
		return 'length: $length, edges: $edges';
	}
}