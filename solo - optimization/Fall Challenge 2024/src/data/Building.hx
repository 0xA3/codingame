package data;

class Building {
	public final type:Int;
	public final id:Int;
	public final pos:Point;
	public final astronautTypes:Array<Int>;
	public final astronautTypesMap:Map<Int, Int> = [];

	public function new( buildingType:Int, buildingId:Int, pos:Point, astronautTypes:Array<Int> ) {
		this.type = buildingType;
		this.id = buildingId;
		this.pos = pos;
		this.astronautTypes = astronautTypes;

		for( astronautType in astronautTypes ) {
			if( !astronautTypesMap.exists( astronautType )) astronautTypesMap.set( astronautType, 1 );
			else astronautTypesMap[astronautType]++;
		}
	}

	public function toString() return 'buildingType: $type, buildingId: $id, pos: $pos, astronautTypes: $astronautTypes';
}