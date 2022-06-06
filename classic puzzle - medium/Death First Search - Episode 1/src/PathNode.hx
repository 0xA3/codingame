class PathNode {
	
	public final id:Int;
	public final neighbors:Array<Int> = [];
	public var previous:Int;
	public var visited:Bool;

	public function new( id:Int, neighbors:Array<Int> ) {
		this.id = id;
		this.neighbors = neighbors;
	}

	public function reset() {
		previous = -1;
		visited = false;
	}

	public function toString() return '$id neighbors $neighbors';
	// public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id';

}