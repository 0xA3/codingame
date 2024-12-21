package ai.data;

class Entity {
	
	public static final NO_ENTITY = new Entity( new Pos( -1, -1 ), "NONE", -999, 0, "", 0, 0 );

	public final pos:Pos; // grid coordinate
	public final type:String; // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
	public final owner:Int; // 1 if your organ, 0 if enemy organ, -1 if neither
	public final organId:Int; // id of this entity if it's an organ, 0 otherwise
	public final organDir:String; // N,E,S,W or X if not an organ
	public final organParentId:Int;
	public final organRootId:Int;

	public function new( pos:Pos, type:String, owner:Int, organId:Int, organDir:String, organParentId:Int, organRootId:Int ) {
		this.pos = pos;
		this.type = type;
		this.owner = owner;
		this.organId = organId;
		this.organDir = organDir;
		this.organParentId = organParentId;
		this.organRootId = organRootId;
	}

	public function toString() return 'x: ${pos.x}, y: ${pos.y}, type: $type, owner: $owner, organId: $organId, organDir: $organDir, organParentId: $organParentId, organRootId: $organRootId';
}