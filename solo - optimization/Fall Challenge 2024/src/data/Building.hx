package data;

class Building {
	public final type:Int;
	public final id:Int;
	public final pos:Point;
	public final astronautTypes:Array<Int>;

	public function new( buildingType:Int, buildingId:Int, pos:Point, astronautTypes:Array<Int> ) {
		this.type = buildingType;
		this.id = buildingId;
		this.pos = pos;
		this.astronautTypes = astronautTypes;
	}

	public function toString() return 'buildingType: $type, buildingId: $id, pos: $pos, astronautTypes: $astronautTypes';
}