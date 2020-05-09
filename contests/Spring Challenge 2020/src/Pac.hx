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
	var collisions:Int = 0;
	public var pelletPriority:Float;

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
				case Unknown: Unknown;
				case Food: Food;
				case Superfood: Superfood;
				case Friend: Friend;
				default: Empty;
			}
		);
		// CodinGame.printErr( 'cleanup target $targetX $targetY from ${CellPrint.print( targetCellType )} to ${CellPrint.print( grid.getCell2d( targetX, targetY ))}' );
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $targetX $targetY to ${CellPrint.print( grid.getCell2d(targetX, targetY))}' );
		isVisible = false;
		pellets.splice( 0, pellets.length ); // clear pellets
	}

	public function update( x:Int, y:Int, typeId:String, speedTurnsLeft:Int, abilityCooldown:Int ) {
		if(( this.x == x && this.y == y ) && ( targetX != x || targetY != y )) {
			collisions++;
		} else {
			collisions = 0;
		}
		// CodinGame.printErr( 'id $id collisions $collisions' );
		this.x = x;
		this.y = y;
		this.typeId = typeId;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true;
		grid.setCell2d( x, y, Empty );
		// CodinGame.printErr( 'update setEmpty $x $y' );
		// if( id == 0 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}

	public function addPellets() {
		final positionIndex = grid.getCellId( x, y );
		for( i in 0...grid.cells.length ) {
			final xp = grid.getCellX( i );
			final yp = grid.getCellY( i );
			switch grid.getCell( i )  {
				case Unknown | Food:
					// final distance = getDistance2( xp, yp );
					final distance = grid.getDistance( positionIndex, i );
					pellets.push({ x: xp, y: yp, value: 1, distance: distance, priority: distance });
				case Superfood:
					// final distance = getDistance2( xp, yp );
					// pellets.push({ x: xp, y: yp, value: 10, distance: distance, priority: distance / 100 });
					final distance = grid.getDistance( positionIndex, i );
					pellets.push({ x: xp, y: yp, value: 10, distance: distance, priority: distance / 10 });
				default: // no-op;
			}
		}
		pellets.sort( sortPelletPriorites );
		pelletPriority = pellets.length > 0 ? pellets[0].priority : 99999;
		// CodinGame.printErr( 'id $id pellet ${pellets[0].x} ${pellets[0].y}' );
		// if( id == 0 ) CodinGame.printErr( 'id $id 1 1 ${CellPrint.print( grid.getCell2d( 1, 1 ))}' );
	}

	public function navigate() {
		if( pellets.length == 0 ) {
			targetX = x;
			targetY = y;
		} else if( collisions > 0 ) {
			final randomId = Std.random( grid.cells.length );
			targetX = grid.getCellX( randomId );
			targetY = grid.getCellY( randomId );
		} else {
			for( pellet in pellets ) {
				final target = grid.getCell2d( pellet.x, pellet.y );
				// if( pellet.x == 21 && pellet.y == 11 ) CodinGame.printErr( 'id $id 21 11 ${CellPrint.print( grid.getCell2d( pellet.x, pellet.y ))}' );
				// CodinGame.printErr( 'id $id ${pellet.x} ${pellet.y} ${CellPrint.print( grid.getCell2d( pellet.x, pellet.y ))}' );
				switch target {
					case Unknown | Food | Superfood:
						targetX = pellet.x;
						targetY = pellet.y;
						break;
					default: // no-op
				}
			}
		}
		targetCellType = grid.getCell2d( targetX, targetY );
		// CodinGame.printErr( '$id get targetCellType $targetX $targetY ${CellPrint.print( targetCellType )}' );
		grid.setCell2d( targetX, targetY, TargetFriend );
		// CodinGame.printErr( '$id navigate setCell target $targetX $targetY TargetFriend' );
	}

	public function go() {
		// if( abilityCooldown == 0 ) return 'SPEED $id';
		return 'MOVE $id $targetX $targetY ${targetX}_${targetY}';
		// return 'MOVE $id $targetX $targetY ${NAMES[id]}';
	}

	public function sortPelletDistances( p1:Pellet, p2:Pellet ) {
		if( p1.distance > p2.distance ) return 1;
		if( p1.distance < p2.distance ) return -1;
		return 0;
	}

	public function sortPelletPriorites( p1:Pellet, p2:Pellet ) {
		if( p1.priority > p2.priority ) return 1;
		if( p1.priority < p2.priority ) return -1;
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

	public static function sortByPelletPriority( p1:Pac, p2:Pac ) {
		if( p1.pelletPriority > p2.pelletPriority ) return 1;
		if( p1.pelletPriority < p2.pelletPriority ) return -1;
		return 0;
	}

}

typedef Pellet = {
	final x:Int;
	final y:Int;
	final value:Float;
	final distance:Float;
	final priority:Float;
}