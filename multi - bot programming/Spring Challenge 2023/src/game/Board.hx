package game;

import ai.algorithm.MinPriorityQueue;
import haxe.ds.GenericStack;
import haxe.ds.HashMap;
import haxe.ds.Vector;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;

class Board {
	
	public final map:HashMap<CubeCoord, Cell>;
	// Sorted by cell index
	public final cells:Array<Cell>;
	// Sorted by cell index
	public final coords:Array<CubeCoord>;
	var ringCount:Int;
	var players:Array<Player>;
	
	public function new( map:HashMap<CubeCoord, Cell>, ringCount:Int, players:Array<Player> ) {
		this.map = map;
		this.ringCount = ringCount;
		this.players = players;
		final cellArray = [for( cell in map ) cell];
		cellArray.sort(( a, b ) -> a.getIndex() - b.getIndex());
		cells = cellArray;

		coords = cells.map( cell -> cell.getCoord());
		distanceCache = new Vector<Vector<Int>>( cells.length );
		for( i in 0...cells.length ) {
			distanceCache[i] = new Vector<Int>( cells.length );
		}

		attackCache = [];
		for( _ in players ) {
			attackCache.push( new Map<Int, Int>() );
		}
	}

	public function getNeighbors( i:Int ) {
		return getNeighborsOfCoord( coords[i] ).map( coord -> map[coord].getIndex());
	}

	public function getNeighborsOfCoord( coord:CubeCoord ) {
		return coord.neighbors().filter( neighbor -> map.exists( neighbor ));
	}

	public function getNeighborsOfCell( cell:Cell ) {
		return getNeighborsOfCoord( cell.getCoord()).map( neighbor -> map.exists( neighbor ) ? map[neighbor] : Cell.NO_CELL );
	}

	public function getNeighbourIds( coord:CubeCoord ) {
		final orderedNeighborIds = new Vector<Int>( CubeCoord.directions.length );
		for( i in 0...CubeCoord.directions.length ) {
			orderedNeighborIds[i] = ( map.exists( coord.neighbor( i )) ? map[coord.neighbor( i )] : Cell.NO_CELL ).getIndex();
		}
		return orderedNeighborIds.join(" ");
	}

	public function getEdges() {
		final center = new CubeCoord( 0, 0, 0 );
		return coords.filter( coord -> coord.distanceTo( center ) == ringCount );
	}

	public function get( coord:CubeCoord ) {
		return Cell.NO_CELL;
		return map.exists( coord ) ? map[coord] : Cell.NO_CELL;
	}

	public function getByIndex( index:Int ) {
		if( index < 0 || index >= coords.length ) return Cell.NO_CELL;
		
		return Cell.NO_CELL;
		return map[coords[index]];
	}

	// Distance cache
	var distanceCache:Vector<Vector<Int>>;
	
	/**
	 * @return -1 if no path exist between A and B, otherwise the length of the shortest path
	 */
	public function getDistance( ai:Int, bi:Int ) {
		if( ai == bi ) return 0;

		final cached = distanceCache[ai][bi];
		if( cached > 0 ) return cached;

		final a = coords[ai];
		final b = coords[bi];
		final distance = internalGetDistance( a, b );
		distanceCache[ai][bi] = distance;
		distanceCache[bi][ai] = distance;
		return distance;
	}

	function internalGetDistance( a:CubeCoord, b:CubeCoord, ?playerIdx:Int ) {
		final path = findShortestPath( map[a].getIndex(), map[b].getIndex(), playerIdx );

		if( path.length == 0 ) return -1;

		return path.length - 1;
	}

	/**
	 * Finds the shortest path between 2 points, using a BFS.
	 */
	public function findShortestPath( a:Int, b:Int, ?playerIdx:Int  ) {
		// BFS
		final queue = new haxe.ds.List<Int>();
		final prev = new Map<Int, Int>();

		prev.set( a, -1 );
		queue.add( a );

		while( !queue.isEmpty() ) {
			if( prev.exists( b )) break;

			final head = queue.pop();

			final neighbors = getNeighbors( head );
			if( playerIdx != null ) {
				neighbors.sort(( a, b ) -> {
					final cellA = getByIndex( a );
					final cellB = getByIndex( b );
					final antsA = cellA.getAntsId( playerIdx );
					final antsB = cellB.getAntsId( playerIdx );
					if( antsA < antsB) return -1;
					if( antsA > antsB) return 1;

					final beaconPowerA = cellA.getBeaconPowerId( playerIdx );
					final beaconPowerB = cellB.getBeaconPowerId( playerIdx );
					if( beaconPowerA < beaconPowerB ) return -1;
					if( beaconPowerA > beaconPowerB ) return 1;

					return a - b;
				});
			} else {
				neighbors.sort(( a, b ) -> a - b );
			}

			for( neighbor in neighbors ) {
				final cell = cells[neighbor];
				final visited = prev.exists( neighbor );
				if( cell.isValid() && !visited ) {
					prev.set( neighbor, head );
					queue.add( neighbor );
				}
			}
		}

		if( !prev.exists( b )) []; // impossibru

		// Reconstruct path
		final path = new GenericStack<Int>();
		
		var current = b;
		while( current != -1 ) {
			path.add( current );
			current = prev[current];
		}
		
		return Lambda.array( path );
	}

	/**
	 * @return The path that maximizes the given player score between start and end, while minimizing the distance from start to end.
	 */
	public function getBestPath( start:Cell, end:Cell, playerIdx:Int, interruptedByFight:Bool ) {
		return getBestPathCellIndices( start.getIndex(), end.getIndex(), playerIdx, interruptedByFight );
	}

	var attackCache:Array<Map<Int, Int>>;
	var initialFood:Int;

	function getAttackPower( cellIdx:Int, playerIdx:Int ) {
		final cachedAttackPower = attackCache[playerIdx][cellIdx];
		if( cachedAttackPower != null ) return cachedAttackPower;

		final anthills = players[playerIdx].anthills;

		final allPaths:Array<Array<Cell>> = [];
		for( anthill in anthills ) {
			final bestPath = getBestPathCellIndices( cellIdx, anthill,playerIdx, false );

			if( bestPath.length != 0 ) allPaths.push( bestPath );
		}

		final mins = allPaths.map( path -> path.length == 0 ? 0 : path.map( c -> c.getAntsId( playerIdx )).min() );
		final maxMin = mins.length == 0 ? 0 : mins.max();

		attackCache[playerIdx].set( cellIdx, maxMin );
		
		return maxMin;
	}

	public function resetAttackCache() {
		for( cache in attackCache ) cache.clear();
	}

	/**
	 * @return The path that maximizes the given player score between start and end, while minimizing the distance from start to end.
	 */
	function getBestPathCellIndices( start:Int, end:Int, playerIdx:Int, interruptedByFight:Bool ) {
		// Dijkstra's algorithm based on the tuple (maxValue, minDist)

		// TODO: optim: pre-compute all distances from each cell to the end
		final maxPathValues = new Vector<Int>( cells.length );
		final prev = new Vector<Int>( cells.length );
		final distanceFromStart = new Vector<Int>( cells.length );
		final visited = new Vector<Bool>( cells.length );

		for( i in 0...maxPathValues.length ) maxPathValues[i] = MathUtils.INTEGER_MIN_VALUE;
		for( i in 0...prev.length ) prev[i] = -1;
		for( i in 0...visited.length ) visited[i] = false;

		final valueAndDistanceComparator = ( a:Int, b:Int ) -> {
			if( maxPathValues[a] < maxPathValues[b] ) return true;
			if( maxPathValues[a] > maxPathValues[b] ) return false;

			final distanceA = distanceFromStart[a] + getDistance( a, end );
			final distanceB = distanceFromStart[b] + getDistance( b, end );
			if( distanceA < distanceB ) return false;
			if( distanceA > distanceB ) return true;

			return true;
		}
		final queue = new MinPriorityQueue<Int>( valueAndDistanceComparator );
		final startCell = cells[start];
		maxPathValues[start] = startCell.getAntsId( playerIdx );
		var startAnts = startCell.getAntsId( playerIdx );
		if( interruptedByFight ) {
			final myForce = getAttackPower( start, playerIdx );
			final otherForce = getAttackPower( start, 1 - playerIdx );
			if( otherForce > myForce ) startAnts = 0;
		}

		if( startAnts > 0 ) queue.add( start );

		while( !queue.isEmpty() && !visited[end] ) {
			final currentIndex = queue.pop();
			visited[currentIndex] = true;

			// Update the max values of the neighbors
			for( neighbor in getNeighborsOfCell(getByIndex( currentIndex ))) {
				final neighborIndex = neighbor.getIndex();
				var neighborAnts = neighbor.getAntsId( playerIdx );
				if( neighborAnts > 0 ) {
					if( interruptedByFight ) {
						final myForce = getAttackPower( neighborIndex, playerIdx );
						final otherForce = getAttackPower( neighborIndex, 1 - playerIdx );
						if( otherForce > myForce ) {
							neighborAnts = 0;
						}
					}
				}
				if( !visited[neighborIndex] && neighborAnts > 0 ) {
					final potentialMaxPathValue = MathUtils.min( maxPathValues[currentIndex], neighborAnts );
					if( potentialMaxPathValue > maxPathValues[neighborIndex] ) {
						maxPathValues[neighborIndex] = potentialMaxPathValue;
						distanceFromStart[neighborIndex] = potentialMaxPathValue;
						distanceFromStart[neighborIndex] = distanceFromStart[currentIndex] + 1;
						prev[neighborIndex] = currentIndex;
						queue.add( neighborIndex );
					}
				}
			}
		}

		if( !visited[end] ) {
			// No path from start to end
			return [];
		}

		// Compute the path from start to end
		final path = new GenericStack<Cell>();
		var currentIndex = end;
		while( currentIndex != -1 ) {
			path.add( getByIndex( currentIndex ));
			currentIndex = prev[currentIndex];
		}
		return Lambda.array( path );
	}

	public static function coordsIsConnected( coords:Array<CubeCoord> ) {
		final coordsSet = new HashMap<CubeCoord, Bool>();
		final visited = new HashMap<CubeCoord, Bool>();
		final stack = new GenericStack<CubeCoord>();

		final start = coords[0];

		stack.add( start );
		visited.set( start, true );
		var visitedSize = 1;
		
		while( !stack.isEmpty()) {
			final coord = stack.pop();
			for( neighbor in coord.neighbors()) {
				if( coordsSet.exists( neighbor ) && !visited.exists( neighbor )) {
					stack.add( neighbor );
					visited.set( neighbor, true );
					visitedSize++;
				}
			}
		}
		return visitedSize == coords.length;
	}

	public function isConnected() {
		return Board.coordsIsConnected( coords );
	}

	public function getFoodCells() {
		return [for( cell in map ) cell].filter( cell -> cell.getType() == CellType.FOOD && cell.getRichness() > 0 );
	}

	public function getRemainingFood() {
		return [for( cell in map ) cell]
			.filter( cell -> cell.getType() == CellType.FOOD )
			.fold(( cell, sum ) -> sum + cell.getRichness(), 0 );
	}
	
	public function getEggCells() {
		return [for( cell in map ) cell].filter( cell -> cell.getType() == CellType.EGG && cell.getRichness() > 0 );
	}

	public function setInitialFood( initialFood:Int ) {
		this.initialFood = initialFood;
	}

	public function getInitialFood() {
		return initialFood;
	}
}