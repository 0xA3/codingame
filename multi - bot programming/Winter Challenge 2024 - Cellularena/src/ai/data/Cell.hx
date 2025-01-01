package ai.data;

import ai.data.TCell;
import ai.data.TDir;
import xa3.math.Pos;

class Cell {
	
	public static final NO_CELL = new Cell( new Pos( -1, -1 ), TCell.NoCell, -999, -1, TDir.X, -1, -1 );

	public final pos:Pos; // grid coordinate
	public var type:TCell; // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
	public var owner:Int; // 1 if your organ, 0 if enemy organ, -1 if neither
	public var organId:Int; // id of this entity if it's an organ, 0 otherwise
	public var organDir:TDir; // N,E,S,W or X if not an organ
	public var organParentId:Int;
	public var organRootId:Int;

	public final neighbors:Array<Cell> = [];

	public function new( pos:Pos, type:TCell, owner:Int, organId:Int, organDir:TDir, organParentId:Int, organRootId:Int ) {
		this.pos = pos;
		this.type = type;
		this.owner = owner;
		this.organId = organId;
		this.organDir = organDir;
		this.organParentId = organParentId;
		this.organRootId = organRootId;
	}

	public static function createEmptyCell( pos:Pos ) {
		return new Cell( pos, Empty, -1, 0, TDir.X, 0, 0 );
	}

	public function removeNeighbor( cell:Cell) {
		neighbors.remove( cell );
	}

	public function reset() {
		type = TCell.Empty;
		owner = -1;
		organId = 0;
		organDir = TDir.X;
		organParentId = 0;
		organRootId = 0;
	}

	public function toString() return 'pos: $pos, type: $type, owner: $owner, organId: $organId, organDir: $organDir, organParentId: $organParentId, organRootId: $organRootId, neighbor positions: [${neighborsToString()}]';

	public function neighborsToString() return [for( neighbor in neighbors ) '${neighbor.pos}' ].join(", ");
	
}