package ai.data;

import xa3.math.Pos;

class Town {
	
	public final id:Int;
	public final pos:Pos;
	public final desiredConnections:Array<Int>;

	public function new( id:Int, pos:Pos, desiredConnections:Array<Int> ) {
		this.pos = pos;
		this.id = id;
		this.desiredConnections = desiredConnections;
	}
}