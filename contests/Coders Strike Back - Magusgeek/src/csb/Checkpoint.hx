package csb;

class Checkpoint extends Unit {
	
	public function new( u:Unit ) {
		super( u.id, u.x, u.y, u.r, u.vx, u.vy );
	}


}