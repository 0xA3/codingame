package ai.data;

class Entity {
	
	public final x:Int;
	public final y:Int; // grid coordinate
	public final type:String; // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
	public final owner:Int; // 1 if your organ, 0 if enemy organ, -1 if neither
	public final organId:Int; // id of this entity if it's an organ, 0 otherwise
	public final organDir:String; // N,E,S,W or X if not an organ
	public final organParentId:Int;
	public final organRootId:Int;

	public function new( x:Int, y:Int, type:String, owner:Int, organId:Int, organDir:String, organParentId:Int, organRootId:Int ) {
		this.x = x;
		this.y = y;
		this.type = type;
		this.owner = owner;
		this.organId = organId;
		this.organDir = organDir;
		this.organParentId = organParentId;
		this.organRootId = organRootId;
	}

	public function toString() return 'x: $x, y: $y, type: $type, owner: $owner, organId: $organId, organDir: $organDir, organParentId: $organParentId, organRootId: $organRootId';
}