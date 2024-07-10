class Node {
	
	public final name:String;
	public final neighbors:Array<Node> = [];
	
	public var previous:Node;
	public var visited = false;

	public function new( name:String ) {
		this.name = name;
	}

	public function addNeighbor( n:Node ) {
		if( n != this && !neighbors.contains( n )) neighbors.push( n );
	}

	public function toString() return 'name: $name, neighbors: ${neighbors.map( neighbor -> neighbor.name ).join( ", " )}';
}