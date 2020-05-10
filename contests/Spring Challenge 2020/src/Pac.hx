import Cell;

enum abstract TPac(Int) {
	var Stop;
	var Move;
	var Speedup;
	var Switch;
}

enum abstract PacFaction(Int) {
	var Me;
	var Enemy;
}

enum abstract PacType(String) {
	var ROCK = "ROCK";
	var PAPER = "PAPER";
	var SCISSORS = "SCISSORS";
}

class Pac {

	public static final STRENGTHS:Map<PacType, Map<PacType, Int>> = [
		ROCK => [ ROCK => 0, PAPER => -1, SCISSORS => 1 ],
		PAPER => [ ROCK => 1, PAPER => 0, SCISSORS => -1 ],
		SCISSORS => [ ROCK => -1, PAPER => 1, SCISSORS => 0 ]
	];
	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final name:String;
	public final faction:PacFaction;
	final grid:Grid;

	var x:Int;
	var y:Int;
	var positionIndex:Int;
	public var type:PacType;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	var destinationX:Int;
	var destinationY:Int;
	var destinationCellType:Cell = Unknown;
	var collisions = 0;
	public var pelletPriority:Float;
	var state:TPac = Stop;

	public var isVisible = true;

	final targets:Array<Target> = [];

	public function new( id:Int, faction:PacFaction, grid:Grid, x:Int, y:Int ) {
		this.id = id;
		this.name = NAMES[id];
		this.faction = faction;
		this.grid = grid;
		this.x = x;
		this.y = y;
		destinationX = x;
		destinationY = y;
	}

	public function cleanUp() {
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $x $y to Empty' );
		
		if( faction == Me ) grid.setCell2d( destinationX, destinationY, destinationCellType );

		// CodinGame.printErr( 'cleanup destination $destinationX $destinationY from ${CellPrint.print( destinationCellType )} to ${CellPrint.print( grid.getCell2d( destinationX, destinationY ))}' );
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $destinationX $destinationY to ${CellPrint.print( grid.getCell2d(destinationX, destinationY))}' );
		isVisible = false;
		targets.splice( 0, targets.length ); // clear targets
	}

	public function update( x:Int, y:Int, type:PacType, speedTurnsLeft:Int, abilityCooldown:Int ) {
		if( state == Move && this.x == x && this.y == y ) {
			collisions++;
			// CodinGame.printErr( 'collisions $collisions' );
		} else {
			collisions = 0;
		}
		// CodinGame.printErr( 'id $id collisions $collisions' );
		this.x = x;
		this.y = y;
		positionIndex = grid.getCellIndex( x, y );
		this.type = type;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true;
		// CodinGame.printErr( 'update setEmpty $x $y' );
		// if( id == 0 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}

	public function placeInGrid() {
		grid.setCell( positionIndex, faction == Me ? MyPac : Enemy( this ));
	}

	public function addTargetsAroundPosition( maxTargets:Int ) {
		for( r in 1...grid.widthHalf + 1 ) {
			final cTop = y - r;
			final cLeft = x - r;
			final cBottom = y + r;
			final cRight = x + r;
			if( targets.length > maxTargets ) break;

			final rTop = Std.int( Math.max( 0, cTop ));
			final rLeft = ( grid.width + cLeft ) % grid.width;
			final rBottom = Std.int( Math.min( grid.height - 1, cBottom ));
			final rRight = cRight % grid.width;

			for( yp in rTop...rBottom ) addTarget( rLeft, yp );
			if( rBottom == cBottom ) for( xp in rLeft...rRight ) addTarget( xp, rBottom );
			for( yp in -rBottom...-rTop ) addTarget( rRight, -yp );
			if( rTop == cTop ) for( xp in -rRight...-rLeft ) addTarget( -xp, rTop );

		}
		targets.sort( sortTargetPriorites );
		pelletPriority = targets.length > 0 ? targets[0].priority : 99999;
		// if( Main.frame > 22 && Main.frame < 30 && id == 1 ) {
			// for( i in 0...Std.int( Math.min(4, targets.length ))) CodinGame.printErr( targets[i] );
		// }
		// CodinGame.printErr( 'id $id pellet0 ${targets[0].x} ${targets[0].y}' );
		// if( id == 0 ) CodinGame.printErr( 'id $id 1 1 ${CellPrint.print( grid.getCell2d( 1, 1 ))}' );
	}

	function addTarget( xp:Int, yp:Int ) {
		switch grid.getCell2d( xp, yp ) {
			case Unknown | Food:
				final distance = grid.getDistance( positionIndex, grid.getCellIndex( xp, yp ));
				// if( xp == 3 && yp == 4 ) CodinGame.printErr( '$id target Food [$xp $yp]  priority $distance' );
				targets.push({ x: xp, y: yp, value: 1, distance: distance, priority: distance });
			case Enemy( enemyPac ):
				final strength = STRENGTHS[this.type][enemyPac.type];
				if( strength > 0 ) {
					final distance = grid.getDistance( positionIndex, grid.getCellIndex( xp, yp ));
					targets.push({ x: xp, y: yp, value: 1, distance: distance, priority: distance / 10 });
					// CodinGame.printErr( '$id target Enemy ${enemyPac.id} priority ${distance / 10}' );
				}

			default: // no-op;
		}
	}

	public function addSuperPellets( superPellets:Map<Int, Bool> ) {
		for( pelletPositionIndex in superPellets.keys()) {
			final distance = grid.getDistance( positionIndex, pelletPositionIndex );
			final xp = grid.getCellX( pelletPositionIndex );
			final yp = grid.getCellY( pelletPositionIndex );
			targets.push({ x: xp, y: yp, value: 10, distance: distance, priority: distance / 20 });
			// if( id == 3 ) CodinGame.printErr( '$id addSuperPellets [$xp $yp]   ${distance / 20}' );
		}
	}

	public function navigate() {
		
		if( targets.length == 0 ) {
			// stop
			destinationX = x;
			destinationY = y;
		} else if( collisions > 0 ) {
			// move to random position
			final randomId = Std.random( grid.cells.length );
			destinationX = grid.getCellX( randomId );
			destinationY = grid.getCellY( randomId );
		} else {
			for( target in targets ) {
				final targetType = grid.getCell2d( target.x, target.y );
				// if( pellet.x == 21 && pellet.y == 11 ) CodinGame.printErr( 'id $id 21 11 ${CellPrint.print( grid.getCell2d( pellet.x, pellet.y ))}' );
				// CodinGame.printErr( 'id $id ${pellet.x} ${pellet.y} ${CellPrint.print( grid.getCell2d( pellet.x, pellet.y ))}' );
				switch targetType {
					case MyDestination: // don't send my pacs to the same destination
					default:
						destinationX = target.x;
						destinationY = target.y;
						break;
				}
			}
		}
		destinationCellType = grid.getCell2d( destinationX, destinationY );
		// if( id == 1 ) CodinGame.printErr( '$id destination $destinationX $destinationY ${destinationCellType}' );
		grid.setCell2d( destinationX, destinationY, MyDestination );
		// CodinGame.printErr( '$id navigate setCell destination $destinationX $destinationY MyTarget' );
	}

	public function go() {
		if( abilityCooldown == 0 ) {
			state = Speedup;
			return 'SPEED $id ${destinationX}:${destinationY}';
		}
		
		state = Move;
		return 'MOVE $id $destinationX $destinationY ${destinationX}:${destinationY}';
		// return 'MOVE $id $destinationX $destinationY ${NAMES[id]}';
	}

	public function sortTargetPriorites( p1:Target, p2:Target ) {
		if( p1.priority > p2.priority ) return 1;
		if( p1.priority < p2.priority ) return -1;
		return 0;
	}

	public function getVisibleCellIndices() {
		return grid.getVisibleCellIndices( x, y );
	}

	public static function sortByPelletPriority( p1:Pac, p2:Pac ) {
		if( p1.pelletPriority > p2.pelletPriority ) return 1;
		if( p1.pelletPriority < p2.pelletPriority ) return -1;
		return 0;
	}

}

typedef Target = {
	final x:Int;
	final y:Int;
	final value:Float;
	final distance:Float;
	final priority:Float;
}