class PathNodeBFS {
	
	public static final NO_NODE = new PathNodeBFS( null, -1, Pos.NO_POS );
	
	public final previous:PathNodeBFS;
	public final id:Int;
	public final pos:Pos;
	public var visited = false;

	public function new( previous:PathNodeBFS, id:Int, pos:Pos ) {
		this.previous = previous;
		this.id = id;
		this.pos = pos;
	}

	public function toString() return '${pos.x}:${pos.y}';
}
