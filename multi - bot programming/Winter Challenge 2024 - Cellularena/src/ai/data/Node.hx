package ai.data;

import xa3.math.Pos;

class Node {
	
	public static final NO_NODE = new Node( 0, new Pos( -1, -1 ), 0 );

	public final startCellId:Int;
	public final pos:Pos;
	public final distance:Int;
	public final parent:Node;

	public function new( startCellId:Int, pos:Pos, distance = 1, ?parent:Node ) {
		this.startCellId = startCellId;
		this.pos = pos;
		this.distance = distance;
		this.parent = parent == null ? Node.NO_NODE : parent;
	}

	public function toString() return 'parent: ${parent.pos}, pos: $pos, distance: $distance';
}