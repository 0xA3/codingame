class Pac {

	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final name:String;
	final grid:Grid;

	var x:Int;
	var y:Int;
	var typeId:String;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	public var isVisible = true;

	final pellets:Array<Pellet> = [];

	public function new( id:Int, grid:Grid ) {
		this.id = id;
		this.name = NAMES[id];
		this.grid = grid;
	}

	public function update( x:Int, y:Int, typeId:String, speedTurnsLeft:Int, abilityCooldown:Int ) {
		this.x = x;
		this.y = y;
		this.typeId = typeId;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true;
		pellets.splice( 0, pellets.length ); // clear pellets
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
	}

	public function addPellets() {
		for( i in 0...grid.cells.length ) {
			final xp = grid.getCellX( i );
			final yp = grid.getCellY( i );
			switch grid.getCell( i )  {
				case Unknown: pellets.push({ x: xp, y: yp, value: 1, distance: getDistance2( xp, yp ) });
				case Food(value): pellets.push({ x: xp, y: yp, value: value, distance: getDistance2( xp, yp ) });
				default: // no-op;
			}
		}
	}

	public function getVisibleCellIds() {
		return grid.getVisibleCellIds( x, y );
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
		if( pellets.length == 0 ) return 'MOVE $id $x $y $name';
		pellets.sort( sortPelletDistances );
		// CodinGame.printErr( 'move from x $x y $y to ${pellets[0]}' );
		return 'MOVE $id ${pellets[0].x} ${pellets[0].y} $name';
	}

	public function sortPelletDistances( p1:Pellet, p2:Pellet ) {
		if( p1.distance > p2.distance ) return 1;
		if( p1.distance < p2.distance ) return -1;
		return 0;
	}

}

typedef Pellet = {
	final x:Int;
	final y:Int;
	final value:Float;
	final distance:Float;
}