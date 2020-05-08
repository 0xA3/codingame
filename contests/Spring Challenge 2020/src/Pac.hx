class Pac {

	final id:Int;
	final grid:Grid;

	var x:Int;
	var y:Int;
	var typeId:String;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	final pellets:Array<Pellet> = [];

	public function new( id:Int, grid:Grid ) {
		this.id = id;
		this.grid = grid;
	}

	public function update( x:Int, y:Int, typeId:String, speedTurnsLeft:Int, abilityCooldown:Int ) {
		this.x = x;
		this.y = y;
		this.typeId = typeId;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		pellets.splice( 0, pellets.length );
	}

	public function addPellet( xp:Int, yp:Int, value:Int ) {
		final pellet = new Pellet( xp, yp, value, getDistance2( xp, yp ));
		pellets.push( pellet );
	}

	inline function getDistance( xp:Int, yp:Int ) {
		return Math.sqrt( getDistance2( xp, yp ));
	}

	inline function getDistance2( xp:Int, yp:Int ) {
		final dx = xp - x;
		final dy = yp - y;
		return dx * dx + dy * dy;
	}

	public function move() {
		if( pellets.length == 0 ) return 'MOVE $id 0 0';
		pellets.sort( Pellet.sortByDistance );
		// CodinGame.printErr( 'move from x $x y $y to ${pellets[0]}' );
		return 'MOVE $id ${pellets[0].x} ${pellets[0].y}';
	}
}