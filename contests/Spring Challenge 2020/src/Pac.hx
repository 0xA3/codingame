import Cell;

enum abstract TPac(Int) {
	var Stop;
	var Move;
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

typedef Neighbor = {
	var index:Int;
	var priority:Int;
}

class Pac {

	public static inline var MAX_IMPORTANCE = 30;
	
	public static inline var IMPORTANCE_FOOD = 1			/ MAX_IMPORTANCE;
	public static inline var IMPORTANCE_SUPERFOOD = 20		/ MAX_IMPORTANCE;
	public static inline var IMPORTANCE_ENEMY = 10			/ MAX_IMPORTANCE;
	public static inline var IMPORTANCE_EVADE = 30			/ MAX_IMPORTANCE;

	public static final STRENGTHS:Map<PacType, Map<PacType, Int>> = [
		ROCK => [ ROCK => 0, PAPER => -1, SCISSORS => 1 ],
		PAPER => [ ROCK => 1, PAPER => 0, SCISSORS => -1 ],
		SCISSORS => [ ROCK => -1, PAPER => 1, SCISSORS => 0 ]
	];
	
	public static final BEAT_TYPE = [ROCK => PAPER, PAPER => SCISSORS, SCISSORS => ROCK];

	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final name:String;
	public final faction:PacFaction;
	final grid:Grid;

	var x:Int;
	var y:Int;
	var positionIndex:Int;
	public var type:PacType;
	var nextType:PacType;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	var destinationCellType:Cell = Unknown;
	var destinationX:Int;
	var destinationY:Int;
	
	public var vx = 0;
	public var vy = 0;
	public var speed:Bool;
	
	var state:TPac = Stop;
	var collisions = 0;
	var danger = 0.0;

	public var isVisible = true;

	public final targets:Array<Target> = [];
	public final enemies:Array<Pac> = [];

	var visibleCellIndices:Array<Int> = [];

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
		enemies.splice( 0, enemies.length ); // clear enemies
	}

	public function update( x:Int, y:Int, type:PacType, speedTurnsLeft:Int, abilityCooldown:Int ) {
		collisions = ( state != Stop && this.x == x && this.y == y ) ? collisions + 1 : 0;
		
		vx = ( grid.width + x - this.x ) % grid.width;
		vy = y - this.y;
		speed = speedTurnsLeft > 0;

		// CodinGame.printErr(( faction == Me ? "My" : "Enemy" ) + ' id $id v $vx $vy' );
		this.x = x;
		this.y = y;
		positionIndex = grid.getCellIndex( x, y );
		this.type = type;
		nextType = type;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true;
		visibleCellIndices = grid.getVisibleCellIndices( x, y );
		// CodinGame.printErr( 'update setEmpty $x $y' );
		// if( id == 0 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}

	public function placeInGrid() {
		grid.setCell( positionIndex, faction == Me ? MyPac : EnemyPac( this ));
	}

	public function addSuperPellets( superPellets:Map<Int, Bool> ) {
		for( pelletPositionIndex in superPellets.keys()) {
			final path = grid.getPath( positionIndex, pelletPositionIndex );
			final cost = path.cost;
			final xp = grid.getCellX( pelletPositionIndex );
			final yp = grid.getCellY( pelletPositionIndex );
			targets.push({ index: grid.getCellIndex( xp, yp ), x: xp, y: yp, path: path, priority: getPriority( cost, IMPORTANCE_SUPERFOOD )});
			// if( id == 3 ) CodinGame.printErr( '$id addSuperPellets [$xp $yp]   ${distance / 20}' );
		}
	}

	public function addTargetsAroundPosition( maxTargets:Int ) {
		for( r in 1...grid.widthHalf + 1 ) {
			final cTop = y - r;
			final cLeft = x - r;
			final cBottom = y + r;
			final cRight = x + r;
			if( targets.length > maxTargets ) break;

			final rTop = Std.int( Math.max( 0, cTop ));
			final rBottom = Std.int( Math.min( grid.height - 1, cBottom ));

			final rLeft = ( grid.width + cLeft ) % grid.width;
			for( yp in rTop...rBottom ) addTarget( rLeft, yp );
			
			if( rBottom == cBottom ) for( xp in cLeft...cRight ) {
				final rp = ( grid.width + xp ) % grid.width;
				addTarget( rp, rBottom );
			}
			final rRight = cRight % grid.width;
			for( yp in -rBottom...-rTop ) addTarget( rRight, -yp );
			
			if( rTop == cTop ) for( xp in -cRight...-cLeft ) {
				final rp = ( grid.width - xp ) % grid.width;
				addTarget( rp, rTop );
			}
		}
		
		targets.sort( sortTargetPriorites );
		// firstTargetPriority = targets.length > 0 ? targets[0].priority : 99999;
		// if( Main.frame > 22 && Main.frame < 30 && id == 1 ) {
			// for( i in 0...Std.int( Math.min(4, targets.length ))) CodinGame.printErr( targets[i] );
		// }
		// CodinGame.printErr( 'id $id target0 ${targets[0].x} ${targets[0].y} ${targets[0].priority}' );
		// if( id == 0 ) CodinGame.printErr( 'id $id 1 1 ${CellPrint.print( grid.getCell2d( 1, 1 ))}' );
	}

	function addTarget( xp:Int, yp:Int ) {
		final cell = grid.getCell2d( xp, yp );
		switch cell {
			case Unknown | Food:
				final path = grid.getPath( positionIndex, grid.getCellIndex( xp, yp ));
				final cost = path.cost;
					// if( xp == 3 && yp == 4 ) CodinGame.printErr( '$id target Food [$xp $yp]  priority $distance' );
				targets.push({ index: grid.getCellIndex( xp, yp ), x: xp, y: yp, path: path, priority: getPriority( cost, IMPORTANCE_FOOD )});
			// case EnemyPac( enemyPac ):
				// if( iCanSeeCell( xp, yp )) addEnemyPac( xp, yp, enemyPac );
			default: // no-op;
		}
	}

	public function addEnemies( enemyPacs:Map<Int, Pac> ) {
		for( enemy in enemyPacs ) {
			if( enemy.isVisible ) {
				enemies.push( enemy );
			}
		}
	}

	// inline function addEnemyPac( xp:Int, yp:Int, enemyPac:Pac ) {
	// 	// CodinGame.printErr( '$id can see enemy ${enemyPac.id}' );
	// 	final strength = STRENGTHS[this.type][enemyPac.type];
	// 	// CodinGame.printErr( '$id target Enemy strength $strength' );
	// 	if( strength > 0 ) {
	// 		attackEnemy( xp, yp, enemyPac );
	// 	} else {
	// 		// Flight or Switch ?
	// 		nextType = BEAT_TYPE[type];
	// 		// CodinGame.printErr( '$id set nextType $nextType' );
	// 	}
	// // } else {
	// 	// CodinGame.printErr( '$id can not see enemy ${enemyPac.id}' );
	// }

	// inline function attackEnemy( xp:Int, yp:Int, enemyPac:Pac ) {
	// 	final path = grid.getPath( positionIndex, grid.getCellIndex( xp, yp ));
	// 	final cost = path.cost;
	// 	targets.push({ index: grid.getCellIndex( xp, yp ), x: xp, y: yp, path: path, priority: getPriority( cost, IMPORTANCE_ENEMY )});
	// 	// CodinGame.printErr( '$id target Enemy ${enemyPac.id} priority ${distance / 10}' );
	// }

	// inline function evadeEnemy( xp:Int, yp:Int, enemyPac:Pac ) {
	// 	// final distance = grid.getDistance( positionIndex, grid.getCellIndex( xp, yp ));
	// }


	inline function getPriority( cost:Float, importance:Float ) {
		return 1 / cost * importance;
	}

	public function navigate() {
		final possibleDestinations = grid.getPossibleDestinations( x, y, speed );
		
		// if( id == 4 ) CodinGame.printErr( 'possibleDestinations $possibleDestinations' );
		// if( id == 4 ) CodinGame.printErr( 'possibleDestinations xy ${possibleDestinations.map( d -> grid.cellIndexToString( d )).join(" ")}' );
		
		final destinationPriorities = possibleDestinations.map( _ -> 0.5 );
		if( collisions > 0 ) {
			// move to random position
			final randomDestination = possibleDestinations[Std.random( possibleDestinations.length )];
			final index = possibleDestinations.indexOf( randomDestination );
			destinationPriorities[index] += 0.1;
		}

		if( targets.length == 0 ) {
			destinationPriorities[0] += 0.1;
		} else {
			final steps = speed ? 2 : 1;
			for( step in 1...steps + 1 ) {
				final targetPath = targets[0].path.path;
				if( targetPath.length > step ) {
					final path1 = targets[0].path.path[step];
					final firstStepIndex = grid.getCellIndex( path1.x, path1.y );
					
					// if( id == 4 ) CodinGame.printErr( '$id firstStepXY ${path1.x} ${path1.y}' );
					// if( id == 4 ) CodinGame.printErr( '$id firstStepIndex $firstStepIndex' );
					
					if( possibleDestinations.indexOf( firstStepIndex ) != -1 ) {
						final destinationIndex = possibleDestinations.indexOf( firstStepIndex );
						destinationPriorities[destinationIndex] += targets[0].priority / 2 + step / 10;
					}
				}
			}
		}

		// for( enemy in enemies )
		// }

		// if( id == 4 ) CodinGame.printErr( 'priorities $destinationPriorities' );

		final sortedPriorities = destinationPriorities.copy();
		sortedPriorities.sort(( a, b ) -> {
			if( a > b ) return -1;
			if( b < a ) return 1;
			return 0;
		});

		final destinationIndex = destinationPriorities.indexOf( sortedPriorities[0] );
		final destination = possibleDestinations[destinationIndex];
		destinationX = grid.getCellX( destination );
		destinationY = grid.getCellY( destination );

		destinationCellType = grid.getCell( destination );
		
		// if( id == 4 ) CodinGame.printErr( '$id destination $destinationX $destinationY' );
		
		grid.setCell2d( destinationX, destinationY, MyDestination );
		// CodinGame.printErr( '$id navigate setCell destination $destinationX $destinationY MyTarget' );
	}

	public function go() {
		final dtype = switch destinationCellType {
			case Unknown: "U";
			case Wall: "W";
			case Food: "F";
			case Superfood: "S";
			case EnemyPac(enemyPac): 'E${enemyPac.id}';
			default: "X";
		}

		if( abilityCooldown == 0 ) {
			// if( nextType != type ) {
			// 	state = Switch;
			// 	return 'SWITCH $id $nextType';
			// } else {
				if( danger == 0 ) {
					state = Stop;
					return 'SPEED $id ${destinationX}:${destinationY}$dtype';
				}
			// }
		}
		
		state = destinationX == x && destinationY == y ? Stop : Move;
		return 'MOVE $id $destinationX $destinationY ${destinationX}:${destinationY}$dtype';
		// return 'MOVE $id $destinationX $destinationY ${NAMES[id]}';
	}

	public function sortTargetPriorites( p1:Target, p2:Target ) {
		if( p1.priority > p2.priority ) return -1;
		if( p1.priority < p2.priority ) return 1;
		return 0;
	}

	public function getVisibleCellIndices() {
		return visibleCellIndices;
	}

	function iCanSeeCell( x:Int, y:Int ) {
		final cellIndex = grid.getCellIndex( x, y );
		return visibleCellIndices.indexOf( cellIndex ) != -1;
	}

}

typedef Target = {
	final index:Int;
	final x:Int;
	final y:Int;
	final path:astar.SearchResult;
	final priority:Float;
}