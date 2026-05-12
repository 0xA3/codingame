package ai.data;

import xa3.math.Pos;

class PathNode {
	
	public static final NO_NODE = new PathNode( Pos.NO_POS, [], null, 0, 0 );

	// public var id:String;
	public var posIn:Pos;
	public var previous:PathNode;
	public var depth:Int;
	public var bodyPositions:Array<Pos>;
	public var outsideCount:Int;
	
	public function new( posIn:Pos, bodyPositions:Array<Pos>, previous:PathNode, depth:Int, outsideCount = 0 ) {
		// this.id = id;
		this.posIn = posIn;
		this.bodyPositions = bodyPositions;
		this.previous = previous;
		this.depth = depth;
		this.outsideCount = outsideCount;
	}

	// public static function createId( bodyPositions:Array<Pos> ) return [for( pos in bodyPositions ) '${pos.x}:${pos.y}'].join( "," );

	// public function toString() return 'posIn: $posIn, previous: ${previous.posIn.x}:${previous.posIn.y}';
	public function toString() return 'posIn: $posIn, outsideCount: $outsideCount';
}