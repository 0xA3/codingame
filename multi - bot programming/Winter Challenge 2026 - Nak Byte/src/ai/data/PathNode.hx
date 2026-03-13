package ai.data;

import ai.data.PathNode;
import xa3.math.Pos;

class PathNode {
	
	public static final NO_NODE = new PathNode( Pos.NO_POS, null, 0, 0 );

	public var pos:Pos;
	public var previous:PathNode;
	public var depth:Int;
	public var groundDistance:Int;
	
	public function new( pos:Pos, previous:PathNode, depth:Int, groundDistance:Int ) {
		this.pos = pos;
		this.previous = previous;
		this.depth = depth;
		this.groundDistance = groundDistance;
	}

	public function toString() return 'pos: $pos, previous: ${previous.pos.x}:${previous.pos.y}';
}