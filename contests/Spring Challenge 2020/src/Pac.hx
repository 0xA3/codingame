import Cell;
import PacType;

typedef Neighbor = {
	var index:Int;
	var priority:Int;
}

class Pac {

	public static inline var IMPORTANCE_FOOD = 1;
	public static inline var IMPORTANCE_SUPERFOOD = 9;
	public static inline var IMPORTANCE_ENEMY = 8.5;
	public static inline var IMPORTANCE_EVADE = 10;

	public static final STRENGTHS:Map<PacType, Map<PacType, Int>> = [
		ROCK => [ ROCK => 0, PAPER => -1, SCISSORS => 1 ],
		PAPER => [ ROCK => 1, PAPER => 0, SCISSORS => -1 ],
		SCISSORS => [ ROCK => -1, PAPER => 1, SCISSORS => 0 ]
	];
	
	// public static final BEAT_TYPE = [ROCK => PAPER, PAPER => SCISSORS, SCISSORS => ROCK];
	public static final TYPESWITCH = [ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER];

	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final name:String;
	final grid:Grid;
	var x:Int;
	var y:Int;
	final enemyPacs:Map<Int,EnemyPac>;
	
	var positionIndex:Int;
	public var type:PacType;
	var nextType:PacType;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	var destinationIndex:Int;
	var destinationCellType:Cell = Unknown;
	
	public var vx = 0;
	public var vy = 0;
	public var speed:Bool;
	public var targetX = 0;
	public var targetY = 0;
	public var targetIndex = 0;

	var state:Action = Stop;
	var collisions = 0;

	public var isVisible = true;

	public final pelletTargets:Array<PelletTarget> = [];
	public final strongerEnemies:Array<Enemy> = [];
	public final weakerEnemies:Array<Enemy> = [];

	var destinationPriorities:Array<DestinationPriority> = [];

	var visibleCellIndices:Array<Int> = [];

	public function new( id:Int, grid:Grid, x:Int, y:Int, enemyPacs:Map<Int, EnemyPac> ) {
		this.id = id;
		this.name = NAMES[id];
		this.grid = grid;
		this.x = x;
		this.y = y;
		this.enemyPacs = enemyPacs;

		destinationIndex = grid.getCellIndex( x, y );
	}

	public function reset() {
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $x $y to Empty' );
		
		// if( faction == Me ) grid.setCell2d( destinationX, destinationY, destinationCellType );

		// CodinGame.printErr( 'cleanup destination $destinationX $destinationY from ${CellPrint.print( destinationCellType )} to ${CellPrint.print( grid.getCell2d( destinationX, destinationY ))}' );
		// if( id == 0 ) CodinGame.printErr( 'reset Cell $destinationX $destinationY to ${CellPrint.print( grid.getCell2d(destinationX, destinationY))}' );
		isVisible = false;
		pelletTargets.splice( 0, pelletTargets.length ); // clear pelletTargets
		strongerEnemies.splice( 0, strongerEnemies.length ); // clear enemies
		weakerEnemies.splice( 0, weakerEnemies.length ); // clear enemies
	}

	public function update( x:Int, y:Int, type:PacType, speedTurnsLeft:Int, abilityCooldown:Int ) {
		collisions = switch state {
			case Move(_) if( this.x == x && this.y == y ): collisions + 1;
			default: 0;
		}

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
		nextType = type;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		isVisible = true; // to find my dead pacs and enemy visible pacs
		visibleCellIndices = grid.getVisibleCellIndices( x, y );
		// CodinGame.printErr( 'update setEmpty $x $y' );
		// if( id == 0 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}

	public function updateSuperPellets( superPellets:Map<Int, Bool> ) {
		for( pelletPositionIndex in superPellets.keys()) {
			final path = grid.getPath( positionIndex, pelletPositionIndex );
			final cost = path.cost;
			final xp = grid.getCellX( pelletPositionIndex );
			final yp = grid.getCellY( pelletPositionIndex );
			pelletTargets.push({ index: grid.getCellIndex( xp, yp ), path: path, value: 10, priority: getFoodPriority( IMPORTANCE_SUPERFOOD, cost )});
			// if( id == 0 ) CodinGame.printErr( '$id addSuperPellet index $pelletPositionIndex [$xp $yp]   ${getFoodPriority( cost, IMPORTANCE_SUPERFOOD )}' );
		}
	}

	public function updatePellets( maxPellets:Int ) {
		for( r in 1...grid.widthHalf + 1 ) {
			final cTop = y - r;
			final cLeft = x - r;
			final cBottom = y + r;
			final cRight = x + r;
			if( pelletTargets.length > maxPellets ) break;

			final rTop = Std.int( Math.max( 0, cTop ));
			final rBottom = Std.int( Math.min( grid.height - 1, cBottom ));

			final rLeft = ( grid.width + cLeft ) % grid.width;
			for( yp in rTop...rBottom ) addPellet( rLeft, yp );
			
			if( rBottom == cBottom ) for( xp in cLeft...cRight ) {
				final rp = ( grid.width + xp ) % grid.width;
				addPellet( rp, rBottom );
			}
			final rRight = cRight % grid.width;
			for( yp in -rBottom...-rTop ) addPellet( rRight, -yp );
			
			if( rTop == cTop ) for( xp in -cRight...-cLeft ) {
				final rp = ( grid.width - xp ) % grid.width;
				addPellet( rp, rTop );
			}
		}
		
		pelletTargets.sort( sortPelletPriorites );
		// firstPelletPriority = pelletTargets.length > 0 ? pelletTargets[0].priority : 99999;
		// if( Main.frame > 22 && Main.frame < 30 && id == 1 ) {
			// for( i in 0...Std.int( Math.min(4, pelletTargets.length ))) CodinGame.printErr( pelletTargets[i] );
		// }
		// CodinGame.printErr( 'id $id target0 ${pelletTargets[0].x} ${pelletTargets[0].y} ${pelletTargets[0].priority}' );
		// if( id == 0 ) CodinGame.printErr( 'id $id 1 1 ${CellPrint.print( grid.getCell2d( 1, 1 ))}' );
	}

	inline function getFoodPriority( importance:Float, cost:Float ) {
		return importance / cost;
	}

	function addPellet( xp:Int, yp:Int ) {
		final cell = grid.getCell2d( xp, yp );
		switch cell {
			case Unknown | Food:
				final pelletPositionIndex = grid.getCellIndex( xp, yp );
				final path = grid.getPath( positionIndex, pelletPositionIndex );
				if( path.result != None ) {
					final cost = path.cost;
					pelletTargets.push({ index: grid.getCellIndex( xp, yp ), path: path, value: 1, priority: getFoodPriority( IMPORTANCE_FOOD, cost )});
					// if( id == 0 ) CodinGame.printErr( '$id pellet index $pelletPositionIndex [$xp $yp]   ${getFoodPriority( cost, IMPORTANCE_FOOD )}' );
				} else {
					CodinGame.printErr( 'Error no path found from [$x $y] to $[$xp $yp]' );
				}
				default: // no-op;
		}
	}

	public function updateEnemies() {
		for( enemyPac in enemyPacs ) {
			if( enemyPac.isVisible ) {
				final myStrength = STRENGTHS[type][enemyPac.type];
				final pathToEnemy = grid.getPath( positionIndex, enemyPac.positionIndex );
				final movesAway = if( grid.getCell2d( enemyPac.targetX, enemyPac.targetY ) != Wall ) {
					grid.getPath( positionIndex, enemyPac.targetIndex ).cost > pathToEnemy.cost;
				} else {
					getDistance2( enemyPac.x, enemyPac.y ) > getDistance2( enemyPac.targetX, enemyPac.targetY );
				}
				if( myStrength > 0 ) {
					if( abilityCooldown > 0 ) {
						weakerEnemies.push({ enemyPac: enemyPac, path: pathToEnemy, movesAway: movesAway });
					}
				} else {
					strongerEnemies.push({ enemyPac: enemyPac, path: pathToEnemy, movesAway: movesAway });
				}
			}
		}
		weakerEnemies.sort( sortEnemies );
		strongerEnemies.sort( sortEnemies );
	}

	function sortEnemies( a:Enemy, b:Enemy ) {
		if( a.movesAway && !b.movesAway ) return -1;
		if( !a.movesAway && b.movesAway ) return 1;
		if( a.path.cost > b.path.cost ) return -1;
		if( b.path.cost < a.path.cost ) return 1;
		return 0;
	}

	public function navigate() {
		
		// get cells around pac without walls
		final destinations = grid.getPossibleDestinations( x, y, speed );
		
		// if( id == 1 ) CodinGame.printErr( '$id [$x $y]' );
		
		// init destinations with neutral priority
		destinationPriorities = destinations.map( positionIndex -> { index: positionIndex, priority: 1.0 });
		addPriority( positionIndex, -0.5 );
		// if( id == 4 ) CodinGame.printErr( 'destinations $destinations' );
		// if( id == 4 ) CodinGame.printErr( 'destinations xy ${destinations.map( d -> grid.cellIndexToString( d )).join(" ")}' );
		
		// resolve collisions
		if( collisions > 0 ) {
			final randomDestination = destinationPriorities[Std.random( destinationPriorities.length )];
			// increase random position priority
			randomDestination.priority += 1;
		}

		final steps = speed ? 2 : 1;
		// determine target from pelletTargets
		if( pelletTargets.length > 0 ) {
			final pelletTarget = pelletTargets[0];
			final targetPath = pelletTarget.path.path;
			if( targetPath != null && targetPath.length > steps ) {
				for( step in 1...steps + 1 ) {
					final pathStep = targetPath[step];
					final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
					addPriority( pathIndex, pelletTarget.priority + step * 0.1 );
					// if( id == 0 ) CodinGame.printErr( '$id pathStep index $pathIndex  [${pathStep.x} ${pathStep.y}]' );
				}
			}
		}

		var huntDistance = 999.0;
		// attack weaker enemies when the come to me
		for( enemy in weakerEnemies ) {
			if( !enemy.movesAway ) {
				final pathToEnemy = enemy.path;
				for( step in 1...steps + 1 ) {
					if( pathToEnemy.path.length > step ) {
						final pathStep = pathToEnemy.path[step];
						final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
						addPriority( pathIndex, IMPORTANCE_ENEMY / pathToEnemy.cost );
						huntDistance = Math.min( pathToEnemy.cost, huntDistance );
					}
				}
			}
		}

		var danger = false;
		// avoid stronger enemies when the come to me
		for( enemy in strongerEnemies ) {
			if( enemy.enemyPac.cellsInReach.contains( positionIndex )) {
				danger = true;
				for( index in enemy.enemyPac.cellsInReach ) { // don't go to cells the enemy can reach
					setPriority( index, 0 );
				}
			}
			
			
			
			// if( !enemy.movesAway ) {
			// 	final pathToEnemy = enemy.path;
			// 	for( step in 1...steps + 1 ) {
			// 		if( pathToEnemy.path.length > step ) {
			// 			final pathStep = pathToEnemy.path[step];
			// 			final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
						
			// 			// check if path is in possible destinations
			// 			final destinationIndex = findDestinationIndex( destinationPriorities, pathIndex );
			// 			if( destinationIndex != -1 ) {
							
			// 				destinationPriorities[destinationIndex].priority -= IMPORTANCE_EVADE / pathToEnemy.cost - step / 10;
			// 				// if( id == 1 ) CodinGame.printErr( '$id enemy $IMPORTANCE_ENEMY cost ${pathToEnemy.cost} priority ${destinationPriorities[destinationIndex].priority}' );
			// 				dangerDistance = Math.min( pathToEnemy.cost, dangerDistance );
			// 				layers++;
			// 				// if( id == 0 ) CodinGame.printErr( 'set priority ${destinationPriorities[destinationIndex].priority}' );
			// 			} else {
			// 				CodinGame.printErr( 'Error: Enemy [${pathStep.x},${pathStep.y}] is not in possible destinations' );
			// 			}
			// 		}
			// 	}
			// }
		}

		// for( destinationPriority in destinationPriorities ) destinationPriority.priority /= layers;
		destinationPriorities.sort( sortDestinationPriorities );
		// for( d in destinationPriorities ) {
		// 	if( id == 3 ) CodinGame.printErr( '$id [${grid.getCellX( d.index )}:${grid.getCellY( d.index )}] priority ${d.priority}' );
		// }

		// dangerDistance
		// huntDistance
		// abilityCooldown
		// speed
		// if( id == 1 ) CodinGame.printErr( '$id hunt $huntDistance danger $dangerDistance cooldown $abilityCooldown speed $speed' );
		// if( huntDistance > 2 && dangerDistance > 6 && abilityCooldown == 0 ) {
		// 	state = Speed;
		if( danger && abilityCooldown == 0 ) {
			state = Switch( TYPESWITCH[type] );
		// } else if( !danger && abilityCooldown == 0 ) {
			// state = Speed;
		} else {
			state = Move( destinationPriorities[0].index );
		}
		
		// if( id == 0 ) CodinGame.printErr( 'hightest priority index $destinationIndex ${destinationPriorities[0].priority}' );

		// if( id == 4 ) CodinGame.printErr( '$id destination $destinationX $destinationY' );
		
	}

	function addPriority( index:Int, value:Float ) {
		for( i in 0...destinationPriorities.length ) {
			if( destinationPriorities[i].index == index ) {
				destinationPriorities[i].priority += value;
				// if( id == 3 ) CodinGame.printErr( '$id set priority [${grid.getCellX(index)},${grid.getCellY(index)}] to ${destinationPriorities[i].priority} ');
				return;
			}
		}
		CodinGame.printErr( '$id [$x $y] Error: [${grid.getCellX(index)},${grid.getCellY(index)}] is not in possible destinations' );
	}

	function setPriority( index:Int, value:Float ) {
		for( i in 0...destinationPriorities.length ) {
			if( destinationPriorities[i].index == index ) {
				destinationPriorities[i].priority = value;
				return;
			}
		}
		CodinGame.printErr( '$id [$x $y] Error: [${grid.getCellX(index)},${grid.getCellY(index)}] is not in possible destinations' );
	}

	// function findDestinationIndex( destinations:Array<DestinationPriority>, positionIndex:Int ) {
	// 	for( i in 0...destinations.length ) {
	// 		if( destinations[i].index == positionIndex ) return i;
	// 	}
	// 	return -1;
	// }

	function sortDestinationPriorities( a:DestinationPriority, b:DestinationPriority ) {
		if( a.priority > b.priority ) return -1;
		if( b.priority < a.priority ) return 1;
		return 0;
	}

	public function go() {
		
		switch state {
			case Stop:
				final pacLabel = '${grid.getCellX( positionIndex )}:${grid.getCellY( positionIndex )}';
				return 'MOVE $id ${grid.getCellX( positionIndex )} ${grid.getCellY( positionIndex )} $pacLabel';
			case Move( index ):
				final pacLabel = '${grid.getCellX( index )}:${grid.getCellY( index )}';
				return 'MOVE $id ${grid.getCellX( index )} ${grid.getCellY( index )} $pacLabel';
			case Speed:
				return 'SPEED $id';
			case Switch( pacType ):
				return 'SWITCH $id $pacType';
		}

	}

	public function sortPelletPriorites( p1:PelletTarget, p2:PelletTarget ) {
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

	inline function getDistance2( xp:Int, yp:Int ) {
		final dx = xp - x;
		final dy = yp - y;
		return dx * dx + dy * dy;
	}

	public function mirrorToEnemy() {
		final mirrorX = grid.width - ( x + 1 );
		return new EnemyPac( id, grid, mirrorX, y );
	}
}

typedef PelletTarget = {
	final index:Int;
	final path:astar.SearchResult;
	final value:Int;
	final priority:Float;
}

typedef Enemy = {
	final enemyPac:EnemyPac;
	final path:astar.SearchResult;
	final movesAway:Bool;
}

typedef DestinationPriority = {
	final index:Int;
	var priority:Float;
}