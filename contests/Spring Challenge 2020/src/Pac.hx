import Coordinator.P2;
import haxe.ds.GenericStack;
import Cell;
import PacType;
import PelletManager;

import Random.random;

typedef Neighbor = {
	var index:Int;
	var priority:Int;
}

class Pac {

	public static inline var IMPORTANCE_FOOD = 0.5;
	public static inline var IMPORTANCE_SUPERFOOD = 900;
	// public static inline var IMPORTANCE_ENEMY = 85;
	public static inline var IMPORTANCE_EVADE = 100;
	public static inline var IMPORTANCE_CURRENT_POSITION = -0.5;
	public static inline var IMPORTANCE_PREVIOUS_POSITIONS = -0.4;

	public static final STRENGTHS:Map<PacType, Map<PacType, Int>> = [
		ROCK => [ ROCK => 0, PAPER => -1, SCISSORS => 1 ],
		PAPER => [ ROCK => 1, PAPER => 0, SCISSORS => -1 ],
		SCISSORS => [ ROCK => -1, PAPER => 1, SCISSORS => 0 ]
	];
	
	// public static final BEAT_TYPE = [ROCK => PAPER, PAPER => SCISSORS, SCISSORS => ROCK];
	public static final TYPESWITCH = [ROCK => SCISSORS, PAPER => ROCK, SCISSORS => PAPER];

	public static final NAMES = ["0tto", "1ngmar", "2om", "3ddie", "4ictor"];

	public final id:Int;
	public final pelletManager:PelletManager;
	final grid:Grid;
	var x:Int;
	var y:Int;
	final enemyPacs:Map<Int,EnemyPac>;
	
	public final name:String;
	var positionIndex:Int;
	public var type:PacType;
	var nextType:PacType;
	var speedTurnsLeft:Int;
	var abilityCooldown:Int;

	public var vx = 0;
	public var vy = 0;
	public var speed:Bool;

	var state:Action = Stop;
	var collisions = 0;

	public final previousPositions = new GenericStack<Int>();
	public final strongerEnemies:Array<Enemy> = [];
	public final weakerEnemies:Array<Enemy> = [];

	var destinationPriorities:Array<DestinationPriority> = [];

	var visibleCellIndices:Array<Int> = [];
	public var operationCenterX:Int;
	public var operationCenterY:Int;

	public function new( id:Int, pelletManager:PelletManager, grid:Grid, x:Int, y:Int, enemyPacs:Map<Int, EnemyPac> ) {
		this.id = id;
		this.pelletManager = pelletManager;
		this.grid = grid;
		this.x = x;
		this.y = y;
		this.enemyPacs = enemyPacs;
		operationCenterX = x;
		operationCenterY = y;

		this.name = NAMES[id];
	}

	public function reset() {
		grid.setCell2d( x, y, Empty ); // set cell of currentPosition to Empty
		previousPositions.add( positionIndex );
		// if( id == 1 ) CodinGame.printErr( 'reset Cell $x $y to Empty' );
		
		// if( faction == Me ) grid.setCell2d( destinationX, destinationY, destinationCellType );

		// CodinGame.printErr( 'cleanup destination $destinationX $destinationY from ${CellPrint.print( destinationCellType )} to ${CellPrint.print( grid.getCell2d( destinationX, destinationY ))}' );
		// if( id == 1 ) CodinGame.printErr( 'reset Cell $destinationX $destinationY to ${CellPrint.print( grid.getCell2d(destinationX, destinationY))}' );
		strongerEnemies.splice( 0, strongerEnemies.length ); // clear enemies
		weakerEnemies.splice( 0, weakerEnemies.length ); // clear enemies
	}

	public function update( x:Int, y:Int, type:PacType, speedTurnsLeft:Int, abilityCooldown:Int ) {
		final index = grid.getCellIndex( x, y );
		if( id == 1 ) CodinGame.printErr( '$id update [$x $y]' );
		switch state {
			case Move( destinationIndex ) if( index != destinationIndex ):
				collisions++;
				if( id == 1 ) CodinGame.printErr( '$id [$x $y] collision ${grid.sxy( destinationIndex )}' );
			default: collisions = 0;
		}

		final dx = ( grid.width + x - this.x ) % grid.width;
		final dy = y - this.y;
		vx = dx > 0 ? 1 : dx < 0 ? -1 : 0;
		vy = dy > 0 ? 1 : dy < 0 ? -1 : 0;
		speed = speedTurnsLeft > 0;

		// CodinGame.printErr(( faction == Me ? "My" : "Enemy" ) + ' id $id v $vx $vy' );
		this.x = x;
		this.y = y;
		positionIndex = grid.getCellIndex( x, y );
		this.type = type;
		nextType = type;
		this.speedTurnsLeft = speedTurnsLeft;
		this.abilityCooldown = abilityCooldown;
		
		grid.setCell2d( x, y, Friend ); // set cell of currentPosition
		visibleCellIndices = grid.getVisibleCellIndices( x, y );
		// CodinGame.printErr( 'update setEmpty $x $y' );
		// if( id == 1 ) CodinGame.printErr( '$id update x $x y $y' );
		// CodinGame.printErr( '$id speed $speedTurnsLeft cooldown $abilityCooldown' );
	}
	
	public function updatePellets( superPellets:Map<Int, Bool>, maxPellets:Int ) {
		final superPelletIndices = [for( i in superPellets.keys()) i];
		
		final cx = Std.int(( x + operationCenterX ) / 2 );
		final cy = Std.int(( y + operationCenterY ) / 2 );

		final normalPelletIndices = grid.getCellIndicesAroundPosition( cx, cy, [Unknown, Food], maxPellets );
		pelletManager.updatePellets( positionIndex, superPelletIndices, normalPelletIndices );
	}

	public function updateEnemies() {
		for( enemyPac in enemyPacs ) {
			// if( id == 1 ) if( enemyPac.type != DEAD ) CodinGame.printErr( 'enemyPac ${enemyPac.id} ${grid.sxy( enemyPac.positionIndex)} isVisible ${enemyPac.isVisible}' );
			if( enemyPac.isVisible && enemyPac.type != DEAD ) {
				final myStrength = STRENGTHS[type][enemyPac.type];
				final pathToEnemy = grid.getPath( positionIndex, enemyPac.positionIndex );
				final movesAway = if( grid.getCell2d( enemyPac.targetX, enemyPac.targetY ) != Wall ) {
					grid.getPath( positionIndex, enemyPac.targetIndex ).cost > pathToEnemy.cost;
				} else {
					getDistance2( enemyPac.x, enemyPac.y ) > getDistance2( enemyPac.targetX, enemyPac.targetY );
				}
/*				if( myStrength > 0 ) {
					if( abilityCooldown > 0 ) {
						weakerEnemies.push({ enemyPac: enemyPac, path: pathToEnemy, movesAway: movesAway });
					}
				} else */if( myStrength < 0 ) {
					strongerEnemies.push({ enemyPac: enemyPac, path: pathToEnemy, movesAway: movesAway });
				}
			}
		}
		// weakerEnemies.sort( sortEnemies );
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
		
		final steps = speed ? 2 : 1;
		
		// get cells around pac without walls
		final l1Destinations = grid.getPossibleDestinations( x, y );
		final possibleDestinations = grid.getPossibleDestinations( x, y, speed );
		// init destinations with neutral priority
		destinationPriorities = possibleDestinations.map( index -> { index: index, priority: grid.getCell( index ) == Empty ? 0.5 : 1.0 });
		addPriority( positionIndex, IMPORTANCE_CURRENT_POSITION );
		
		// for( previousPositionIndex in previousPositions ) {
		// 	if( possibleDestinations.contains( previousPositionIndex )) addPriority( previousPositionIndex, IMPORTANCE_PREVIOUS_POSITIONS );
		// }
		
		// resolve collisions
		if( collisions > 0 ) {
			final random = random( collisions + positionIndex, l1Destinations.length );
			final randomIndex = l1Destinations[random];
			// increase random position priority
			addPriority( randomIndex, 3 );
			if( id == 1 ) CodinGame.printErr( '$id collisions $collisions random $random ${grid.sxy( randomIndex )}' );
		}
		
		final p1Priorities = pelletManager.getDestinationPriorities( l1Destinations, pelletManager.pelletTargets );
		for( index => value in p1Priorities ) addPriority( index, value );
		// if( id == 1 ) CodinGame.printErr( '$id p1Priorities ${grid.m2s( p1Priorities )}' );

		if( speed ) {
			final highestL1Index = getHighestIndex( p1Priorities );
			final sx = grid.getCellX( highestL1Index );
			final sy = grid.getCellY( highestL1Index );
			final p2Pellets = pelletManager.createModifiedPelletTargets( highestL1Index, pelletManager.pelletTargets );
			final l2Destinations = grid.getPossibleDestinations( sx, sy );

			if( l2Destinations.length > 2 ) {
				final p2Priorities = pelletManager.getDestinationPriorities( l2Destinations, p2Pellets );
				p2Priorities.remove( positionIndex );
				final highestL2Index = getHighestIndex( p2Priorities );
				for( index => value in p2Priorities ) addPriority( index, value );
				addPriority( highestL2Index, p1Priorities[highestL1Index] );
				// if( id == 1 ) CodinGame.printErr( '$id p2Priorities ${grid.m2s( p2Priorities )}' );
			}
		}
		
		var huntDistance = 999.0;
		// attack weaker enemies when they are in range
		// for( enemy in weakerEnemies ) {
		// 	if( !enemy.movesAway ) {
		// 		final pathToEnemy = enemy.path;
		// 		for( step in 1...steps + 1 ) {
		// 			if( pathToEnemy.path.length > step ) {
		// 				final pathStep = pathToEnemy.path[step];
		// 				final pathIndex = grid.getCellIndex( pathStep.x, pathStep.y );
		// 				addPriority( pathIndex, IMPORTANCE_ENEMY / pathToEnemy.cost );
		// 				huntDistance = Math.min( pathToEnemy.cost, huntDistance );
		// 			}
		// 		}
		// 	}
		// }
		
		// avoid stronger enemies when the come to me
		var danger = false;
		for( enemy in strongerEnemies ) {
			if( enemy.enemyPac.cellsInReach.contains( positionIndex )) {
				danger = true;
			}
			for( index in enemy.enemyPac.cellsInReach ) { // don't go to cells the enemy can reach
				setPriority( index, 0, false );
			}
		}

		destinationPriorities.sort( sortDestinationPriorities );
		final destinationIndex = destinationPriorities[0].index;
		for( d in destinationPriorities ) {
			if( id == 1 ) CodinGame.printErr( '$id ${grid.sxy( positionIndex )} to ${grid.sxy( d.index)} priority ${d.priority}' );
		}

		// dangerDistance
		// huntDistance
		// abilityCooldown
		// speed
		// if( id == 1 ) CodinGame.printErr( '$id hunt $huntDistance danger $dangerDistance cooldown $abilityCooldown speed $speed' );
		// if( huntDistance > 2 && dangerDistance > 6 && abilityCooldown == 0 ) {
		// 	state = Speed;
		if( danger && abilityCooldown == 0 ) {
			state = Switch( TYPESWITCH[type] );
		} else if( !danger && abilityCooldown == 0 ) {
			state = Speed;
		} else if( destinationIndex == positionIndex ) {
			state = Stop;
		} else {
			state = Move( destinationPriorities[0].index );
		}

	}

	function getHighestIndex( m:Map<Int, Float> ) {
		var highestIndex = 0;
		var highestValue = Math.NEGATIVE_INFINITY;
		for( index => value in m ) if( value > highestValue ) {
			highestIndex = index;
			highestValue = value;
		}
		return highestIndex;
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

	function setPriority( index:Int, value:Float, reportError = true ) {
		for( i in 0...destinationPriorities.length ) {
			if( destinationPriorities[i].index == index ) {
				destinationPriorities[i].priority = value;
				return;
			}
		}
		if( reportError ) CodinGame.printErr( '$id [$x $y] Error: [${grid.getCellX(index)},${grid.getCellY(index)}] is not in possible destinations' );
	}

	function getPriority( index:Int ) {
		for( i in 0...destinationPriorities.length ) {
			if( destinationPriorities[i].index == index ) {
				return destinationPriorities[i].priority;
			}
		}
		CodinGame.printErr( '$id [$x $y] Error: [${grid.getCellX(index)},${grid.getCellY(index)}] is not in possible destinations' );
		return 0;
	}

	// function findDestinationIndex( destinations:Array<DestinationPriority>, positionIndex:Int ) {
	// 	for( i in 0...destinations.length ) {
	// 		if( destinations[i].index == positionIndex ) return i;
	// 	}
	// 	return -1;
	// }

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

	function sortDestinationPriorities( a:DestinationPriority, b:DestinationPriority ) {
		if( a.priority > b.priority ) return -1;
		if( b.priority < a.priority ) return 1;
		return 0;
	}

	public function sortPelletPriorites( p1:PelletTarget, p2:PelletTarget ) {
		if( p1.priority > p2.priority ) return -1;
		if( p1.priority < p2.priority ) return 1;
		return 0;
	}

	public function getVisibleCellIndices() {
		return visibleCellIndices;
	}

	inline function iCanSeeCell( x:Int, y:Int ) {
		return visibleCellIndices.contains( grid.getCellIndex( x, y ));
	}

	public inline function getDistance2( xp:Int, yp:Int ) {
		final dx = xp - x;
		final dy = yp - y;
		return dx * dx + dy * dy;
	}

	public function mirrorToEnemy() {
		final mirrorX = grid.width - ( x + 1 );
		return new EnemyPac( id, grid, mirrorX, y );
	}

	public function spos() {
		return '[$x $y]';
	}
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