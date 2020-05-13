import Cell;

enum TPac {
	Stop;
	Move( index:Int );
	Speed;
	Switch( pacType:PacType );
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

	var destinationIndex:Int;
	var destinationCellType:Cell = Unknown;
	
	public var vx = 0;
	public var vy = 0;
	public var speed:Bool;
	public var targetX = 0;
	public var targetY = 0;
	public var targetIndex = 0;

	var state:TPac = Stop;
	var collisions = 0;

	public var isVisible = true;

	public final pelletTargets:Array<PelletTarget> = [];
	public final strongerEnemies:Array<Pac> = [];
	public final weakerEnemies:Array<Pac> = [];

	var visibleCellIndices:Array<Int> = [];

	public function new( id:Int, faction:PacFaction, grid:Grid, x:Int, y:Int ) {
		this.id = id;
		this.name = NAMES[id];
		this.faction = faction;
		this.grid = grid;
		this.x = x;
		this.y = y;
		destinationIndex = grid.getCellIndex( x, y );
	}

	public function cleanUp() {
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

	public function placeInGrid() {
		grid.setCell( positionIndex, faction == Me ? MyPac : EnemyPac( this ));
	}

	public function addSuperPellets( superPellets:Map<Int, Bool> ) {
		for( pelletPositionIndex in superPellets.keys()) {
			final path = grid.getPath( positionIndex, pelletPositionIndex );
			final cost = path.cost;
			final xp = grid.getCellX( pelletPositionIndex );
			final yp = grid.getCellY( pelletPositionIndex );
			pelletTargets.push({ index: grid.getCellIndex( xp, yp ), path: path, value: 10, priority: getPriority( cost, IMPORTANCE_SUPERFOOD )});
			// if( id == 3 ) CodinGame.printErr( '$id addSuperPellets [$xp $yp]   ${distance / 20}' );
		}
	}

	public function addPelletsAroundPosition( maxPellets:Int ) {
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

	function addPellet( xp:Int, yp:Int ) {
		final cell = grid.getCell2d( xp, yp );
		switch cell {
			case Unknown | Food:
				final path = grid.getPath( positionIndex, grid.getCellIndex( xp, yp ));
				final cost = path.cost;
					// if( xp == 3 && yp == 4 ) CodinGame.printErr( '$id target Food [$xp $yp]  priority $distance' );
				pelletTargets.push({ index: grid.getCellIndex( xp, yp ), path: path, value: 1, priority: getPriority( cost, IMPORTANCE_FOOD )});
			// case EnemyPac( enemyPac ):
				// if( iCanSeeCell( xp, yp )) addEnemyPac( xp, yp, enemyPac );
			default: // no-op;
		}
	}

	public function addEnemies( enemyPacs:Map<Int, Pac> ) {
		for( enemyPac in enemyPacs ) {
			if( enemyPac.isVisible ) {
				final typeStrength = STRENGTHS[type][enemyPac.type];
				if( typeStrength > 0 ) {
					weakerEnemies.push( enemyPac );
				} else {
					strongerEnemies.push( enemyPac );
				}
			}
		}
	}

	inline function getPriority( cost:Float, importance:Float ) {
		return 1 / cost * importance;
	}

	public function navigate() {
		
		// get cells around pac without walls
		final destinations = grid.getPossibleDestinations( x, y, speed );
		// init destinations with neutral priority
		final destinationPriorities:Array<DestinationPriority> = destinations.map( positionIndex -> { index: positionIndex, priority: 0.5 });
		
		// if( id == 4 ) CodinGame.printErr( 'destinations $destinations' );
		// if( id == 4 ) CodinGame.printErr( 'destinations xy ${destinations.map( d -> grid.cellIndexToString( d )).join(" ")}' );
		
		// resolve collisions
		if( collisions > 0 ) {
			final randomDestination = destinationPriorities[Std.random( destinationPriorities.length )];
			// increase random position priority
			randomDestination.priority += 0.1;
		}

		final steps = speed ? 2 : 1;
		// determine target from pelletTargets
		if( pelletTargets.length > 0 ) {
			for( step in 1...steps + 1 ) {
				final targetPath = pelletTargets[0].path.path;
				if( targetPath.length > step ) {
					final pathStep = pelletTargets[0].path.path[step];
					final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
					
					// if( id == 0 ) CodinGame.printErr( '$id pathStep index $pathIndex  [${pathStep.x} ${pathStep.y}]' );
					
					// check if path is in possible destinations
					final destinationIndex = findDestinationIndex( destinationPriorities, pathIndex );
					if( destinationIndex != -1 ) {
						destinationPriorities[destinationIndex].priority += pelletTargets[0].priority / 2 + step / 10;
						// if( id == 0 ) CodinGame.printErr( 'set priority ${destinationPriorities[destinationIndex].priority}' );
					} else {
						CodinGame.printErr( 'Error: Pellet [${pathStep.x},${pathStep.y}] is not in possible destinations' );
					}
				}
			}
		}

		// attack weaker enemies when the come to me
		for( enemy in weakerEnemies ) {
			final pathToEnemy = grid.getPath( positionIndex, enemy.positionIndex );
			final movesToMe = if( grid.getCell2d( enemy.targetX, enemy.targetY ) != Wall ) {
				grid.getPath( positionIndex, enemy.targetIndex ).cost > pathToEnemy.cost;
			} else {
				getDistance2( enemy.x, enemy.y ) > getDistance2( enemy.targetX, enemy.targetY );
			}
			if( movesToMe ) {
				for( step in 1...steps + 1 ) {
					if( pathToEnemy.path.length > step ) {
						final pathStep = pathToEnemy.path[step];
						final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
						
						// check if path is in possible destinations
						final destinationIndex = findDestinationIndex( destinationPriorities, pathIndex );
						if( destinationIndex != -1 ) {
							destinationPriorities[destinationIndex].priority += IMPORTANCE_ENEMY / 2 + step / 10;
							// if( id == 0 ) CodinGame.printErr( 'set priority ${destinationPriorities[destinationIndex].priority}' );
						} else {
							CodinGame.printErr( 'Error: Enemy [${pathStep.x},${pathStep.y}] is not in possible destinations' );
						}
					}
				}
			}
		}

		var danger = false;
		// avoid stronger enemies when the come to me
		for( enemy in strongerEnemies ) {
			final pathToEnemy = grid.getPath( positionIndex, enemy.positionIndex );
			final movesToMe = if( grid.getCell2d( enemy.targetX, enemy.targetY ) != Wall ) {
				grid.getPath( positionIndex, enemy.targetIndex ).cost > pathToEnemy.cost;
			} else {
				getDistance2( enemy.x, enemy.y ) > getDistance2( enemy.targetX, enemy.targetY );
			}
			if( movesToMe ) {
				for( step in 1...steps + 1 ) {
					if( pathToEnemy.path.length > step ) {
						final pathStep = pathToEnemy.path[step];
						final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
						
						// check if path is in possible destinations
						final destinationIndex = findDestinationIndex( destinationPriorities, pathIndex );
						if( destinationIndex != -1 ) {
							destinationPriorities[destinationIndex].priority -= IMPORTANCE_ENEMY / 2 + step / 10;
							danger = true;
							// if( id == 0 ) CodinGame.printErr( 'set priority ${destinationPriorities[destinationIndex].priority}' );
						} else {
							CodinGame.printErr( 'Error: Enemy [${pathStep.x},${pathStep.y}] is not in possible destinations' );
						}
					}
				}
			}
		}


		destinationPriorities.sort( sortDestinationPriorities );

		if( !danger && abilityCooldown == 0 ) {
			state = Speed;
		// } else if( danger && abilityCooldown == 0 ) {
			// state = Switch
		} else {
			state = Move( destinationPriorities[0].index );
		}
		// destinationIndex = destinationPriorities[0].index;
		
		// if( id == 0 ) CodinGame.printErr( 'hightest priority index $destinationIndex ${destinationPriorities[0].priority}' );

		// destinationCellType = grid.getCell( destinationIndex );
		
		// if( id == 4 ) CodinGame.printErr( '$id destination $destinationX $destinationY' );
		
		// grid.setCell2d( destinationX, destinationY, MyDestination );
		// CodinGame.printErr( '$id navigate setCell destination $destinationX $destinationY MyPellet' );
	}

	function findDestinationIndex( destinationPriorities:Array<DestinationPriority>, positionIndex:Int ) {
		for( i in 0...destinationPriorities.length ) {
			if( destinationPriorities[i].index == positionIndex ) return i;
		}
		return -1;
	}

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
}

typedef PelletTarget = {
	final index:Int;
	final path:astar.SearchResult;
	final value:Int;
	final priority:Float;
}

typedef PacTarget = {
	final path:astar.SearchResult;
	final pac:Pac;
}

typedef DestinationPriority = {
	final index:Int;
	var priority:Float;
}