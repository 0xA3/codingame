package csb;

import csb.Vector2d.Position;

class Checkpoint {
	
	public final id:Int;
	public final pos:Position;
	public final radius = 600;

	public function new( id:Int, pos:Position ) {
		this.id = id;
		this.pos = pos;
	}


}