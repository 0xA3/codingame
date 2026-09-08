package ai.data;

import xa3.math.Pos;

class Cell {
	
	public final pos:Pos;
	public final regionId:Int;
	public final type:TTerrain;
	
	public var tracksOwnerId = -1;
	public var instability = 0;
	public var isInked = false;
	public var partOfActiveConnections:String;

	public final neighbors:Array<Cell> = [];
	
	public function new( pos:Pos, regionId:Int, type:TTerrain ) {
		this.pos = pos;
		this.regionId = regionId;
		this.type = type;
	}

	public function updateTrackData( tracksOwnerId:Int, instability:Int, isInked:Bool, partOfActiveConnections:String ) {
		this.tracksOwnerId = tracksOwnerId;
		this.instability = instability;
		this.isInked = isInked;
		this.partOfActiveConnections = partOfActiveConnections;
	}

	public function addNeighbor( cell:Cell ) neighbors.push( cell );
}