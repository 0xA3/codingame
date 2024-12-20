package ai.data;

class Node {
	
	public static final NO_NODE = new Node( 0, new Pos( -1, -1 ), 0 );

	public final closestOrganId:Int;
	public final pos:Pos;
	public final distance:Int;

	public function new( closestOrganId:Int, pos:Pos, distance:Int ) {
		this.closestOrganId = closestOrganId;
		this.pos = pos;
		this.distance = distance;
	}

	public function toString() return 'closestOrganId: $closestOrganId, pos: $pos, distance: $distance';
}