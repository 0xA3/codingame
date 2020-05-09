import Cell.CellPrint;

class Pac {

	public static final STATE_IDS = ["ROCK", "PAPER", "SCISSORS"];
	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final name:String;
	final grid:Grid;

	var x:Int;
	var y:Int;
	var typeId:String;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	var targetX:Int;
	var targetY:Int;
	var targetCellType:Cell;

	public var isVisible = true;

	final pellets:Array<Pellet> = [];

	public function new( id:Int, grid:Grid, x:Int, y:Int ) {
		this.id = id;
		this.name = NAMES[id];
		this.grid = grid;
		this.x = x;
		this.y = y;
		targetX = x;
		targetY = y;
	}

	public function cleanUp() {
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $x $y to Empty' );
		
		grid.setCell2d( targetX, targetY, 
			switch targetCellType { // reset cell of target
				case Food: Food;
				case Superfood: Superfood;
				case Friend: Friend;
				default: Empty;
			}
		);
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $targetX $targetY to ${CellPrint.print( grid.getCell2d(targetX, targetY))}' );
		
		pellets.splice( 0, pellets.length ); // clear pellets
	}

	public function update( x:Int, y:Int, typeId:String, speedTurnsLeft:Int, abilityCooldown:Int ) {
		this.x = x;
		this.y = y;
		this.typeId = typeId;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true;
		grid.setCell2d( x, y, Empty );
		// if( id == 0 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}

	public function addPellets() {
		for( i in 0...grid.cells.length ) {
			final xp = grid.getCellX( i );
			final yp = grid.getCellY( i );
			switch grid.getCell( i )  {
				case Unknown | Food : pellets.push({ x: xp, y: yp, value: 1, distance: getDistance2( xp, yp ) });
				case Superfood: pellets.push({ x: xp, y: yp, value: 10, distance: getDistance2( xp, yp ) });
				default: // no-op;
			}
		}
	}

	public function navigate() {
		if( pellets.length == 0 ) {
			targetX = x;
			targetY = y;
		} else {
			pellets.sort( sortPelletDistances );
			for( pellet in pellets ) {
				final target = grid.getCell2d( pellet.x, pellet.y );
				switch target {
					case Food | Superfood:
						targetX = pellet.x;
						targetY = pellet.y;
						break;
					default: // no-op
				}
			}
		}
		targetCellType = grid.getCell2d( targetX, targetY );
		grid.setCell2d( targetX, targetY, TargetFriend );
		// if( id == 0 ) CodinGame.printErr( 'set Cell $targetX $targetY to TargetFriend' );
	}

	public function go() {
		return 'MOVE $id $targetX $targetY Go_${targetX}_${targetY}';
	}

	public function sortPelletDistances( p1:Pellet, p2:Pellet ) {
		if( p1.distance > p2.distance ) return 1;
		if( p1.distance < p2.distance ) return -1;
		return 0;
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

}

typedef Pellet = {
	final x:Int;
	final y:Int;
	final value:Float;
	final distance:Float;
}