package ai.data;

class Node {
	
	public static final NO_NODE = new Node( 0, new Pos( -1, -1 ), 0 );

	public final closestOrganId:Int;
	public final pos:Pos;
	public final distance:Int;
	public final parent:Node;

	public function new( closestOrganId:Int, pos:Pos, distance:Int, ?parent:Node ) {
		this.closestOrganId = closestOrganId;
		this.pos = pos;
		this.distance = distance;
		this.parent = parent;
	}

	public function toString() return 'parent: ${parent.pos}, pos: $pos, distance: $distance';
}