import Cell;

class EnemyPac {

	public final id:Int;
	final grid:Grid;

	public var x:Int;
	public var y:Int;
	public var positionIndex:Int;
	public var type:PacType;
	public var speedTurnsLeft:Int;
	public var abilityCooldown:Int;

	public var vx = 0;
	public var vy = 0;
	public var speed:Bool;
	public var targetX = 0;
	public var targetY = 0;
	public var targetIndex = 0;

	public var isVisible = true;

	public function new( id:Int, grid:Grid, x:Int, y:Int ) {
		this.id = id;
		this.grid = grid;
		this.x = x;
		this.y = y;
	}

	public function cleanUp() {
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
		isVisible = false;
	}

	public function update( x:Int, y:Int, type:PacType, speedTurnsLeft:Int, abilityCooldown:Int ) {
		
		final dx = ( grid.width + x - this.x ) % grid.width;
		final dy = y - this.y;
		vx = dx > 0 ? 1 : dx < 0 ? -1 : 0;
		vy = dy > 0 ? 1 : dy < 0 ? -1 : 0;
		speed = speedTurnsLeft > 0;
		targetX = x + vx * ( speed ? 2 : 1 );
		targetY = x + vy * ( speed ? 2 : 1 );
		targetIndex = grid.getCellIndex( targetX, targetY );

		// CodinGame.printErr(( faction == Me ? "My" : "Enemy" ) + ' id $id v $vx $vy' );
		this.x = x;
		this.y = y;
		positionIndex = grid.getCellIndex( x, y );
		this.type = type;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true; // to find enemy visible pacs
	}

}
