class PathNode {
	
	public final id:Int;
	public final neighbors:Array<Int> = [];
	public var previous = -1;
	public var visited = false;

	public function new( id:Int, neighbors:Array<Int> ) {
		this.id = id;
		this.neighbors = neighbors;
	}

	public function addNeighbor( id:Int ) {
		if( !neighbors.contains( id )) neighbors.push( id );
	}

	public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id prio: $priority}';

}