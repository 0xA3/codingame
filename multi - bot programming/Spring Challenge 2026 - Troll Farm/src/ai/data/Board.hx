package ai.data;

import CodinGame.printErr;
import Std.int;
import astar.map2d.Map2D;
import astar.map2d.types.MovementDirection;
import xa3.math.IntMath;
import xa3.math.Pos;
import ya.Set;

using xa3.math.IntMath;

class Board {
	
	public static inline var GRASS = 0;
	public static inline var WATER = 1;
	public static inline var ROCK = 2;
	public static inline var IRON = 3;
	public static inline var MY_SHACK = 4;
	public static inline var OPP_SHACK = 5;

	public final boardWidth:Int;
	public final boardHeight:Int;
	public final positions:Array<Array<Pos>>;
	public final paths:Array<Array<Array<Pos>>>;
	public final grid:Array<Array<Int>>;
	public final myShack:Pos;
	public final oppShack:Pos;

	public final ironNeighbors:Array<Pos> = [];
	public final ironNeighborPosSet:Set<Pos> = [];
	public final waterNeighbors:Array<Pos> = [];
	public final waterNeighborPosSet:Set<Pos> = [];
	public final plantPositions:Array<Array<Pos>> = [];
	public final maxTreesAroundBase:Array<Array<Int>> = [];
	final treeTypesAroundBase:Map<TResource, Int> = [PLUM => 0, LEMON => 0, APPLE => 0];
	final treeTypeDistances:Map<TResource, Int> = [PLUM => 0, LEMON => 0, APPLE => 0];
	final fruitsAroundBase:Map<TResource, Int> = [PLUM => 0, LEMON => 0, APPLE => 0, BANANA => 0];

	final map2d:Map2D;

	// public final currentBoard:Array<Array<Int>>;
	// public final nextBoard:Array<Array<Int>>;

	public final halfWidth:Int;
	public final thirdWidth:Int;

	public final center:Pos;
	public final neighborOffsets = Pos.createNeighborOffsets();
	
	public var trees:Array<Tree> = [];
	public var treePositionsMap:Map<Pos, Tree> = [];
	public final targetTrees:Map<Pos, Bool> = [];
	public final occupiedPositions:Set<Pos> = [];

	var turn = 0;

	public function new(
		boardWidth:Int,
		boardHeight:Int,
		positions:Array<Array<Pos>>,
		grid:Array<Array<Int>>,
		paths:Array<Array<Array<Pos>>>,
		myShack:Pos,
		oppShack:Pos,
		trees:Array<Tree>,
		treePositionsMap:Map<Pos, Tree>
	) {
		this.boardWidth = boardWidth;
		this.boardHeight = boardHeight;
		this.positions = positions;
		this.grid = grid;
		this.paths = paths;
		this.myShack = myShack;
		this.oppShack = oppShack;
		this.trees = trees;
		this.treePositionsMap = treePositionsMap;

		// currentBoard = [for( y in 0...boardHeight ) []];
		// nextBoard = [for( y in 0...boardHeight ) []];
		
		halfWidth = int( boardWidth / 2 );
		thirdWidth = int( boardWidth / 3 );
		
		center = positions[int( boardHeight / 2 )][halfWidth];

		final movementDirection = FourWay;
		
		map2d = new Map2D( boardWidth, boardHeight, movementDirection );
		final costs = [0 => Map2D.defaultCosts];
		
		map2d.setMap( [for( y in 0...boardHeight ) for( x in 0...boardWidth ) grid[y][x]] );
		map2d.setCosts( costs );
		map2d.configureCache( true, 1024 );
	}

	public function reset() {
		targetTrees.clear();
		occupiedPositions.clear();
	}

	public function addWaterAndIronNeighbors() {
		// printErr( 'addWaterAndIronNeighbors' );
		for( y in 0...boardHeight ) {
			for( x in 0...boardWidth ) {
				final pos = positions[y][x];
				final cell = getCell( pos );
				// printErr( 'pos $pos cell $cell' );
				if( cell != Board.GRASS ) continue;

				var isIronNeighbor = false;
				var isWaterNeighbor = false;
				final neighbors = getAllNeighbors( pos );
				for( neighbor in neighbors ) {
					if( getCell( neighbor ) == Board.IRON ) isIronNeighbor = true;
					if( getCell( neighbor ) == Board.WATER ) isWaterNeighbor = true;
				}
				// printErr( 'pos $pos isIronNeighbor $isIronNeighbor isWaterNeighbor $isWaterNeighbor' );
				if( isIronNeighbor ) {
					ironNeighbors.push( pos );
					ironNeighborPosSet.add( pos );
				}
				if( isWaterNeighbor ) {
					waterNeighbors.push( pos );
					waterNeighborPosSet.add( pos );
				}
			}
		}
	}

	public function addPlantPositions() {
		if( myShack == Pos.NO_POS ) throw 'Error: no myShack';
		for( _ in 0...boardWidth + boardHeight ) plantPositions.push( [] );
		
		for( y in 0...positions.length ) for( pos in positions[y] ) if( getCell( pos ) == Board.GRASS ) {
			final distance = getDistance( pos, myShack );
			final depth = distance - ( waterNeighborPosSet.contains( pos ) ? 1 : 0 );
			// printErr( 'pos $pos distance $distance depth $depth ${plantPositions[depth]}' );
			if( plantPositions[depth] == null ) plantPositions[depth] = [];
			
			plantPositions[depth].push( pos );
		}
		// for( depth in 0...3 ) for( pos in plantPositions[depth] ) printErr( 'depth $depth pos $pos' );
	}

	public function getPlantPosition( trollPos:Pos ) {
		for( depth in 0...plantPositions.length ) {
			final plantPositionsOfDepth = plantPositions[depth];
			plantPositionsOfDepth.sort(( a, b ) -> {
				final d1 = getDistance( trollPos, a );
				final d2 = getDistance( trollPos, b );
				if( d1 < d2 ) return -1;
				else if( d1 > d2 ) return 1;
				else return 0;
			});

			for( plantPos in plantPositionsOfDepth ) {
				// printErr( 'plantPos $plantPos distance ${getDistance( trollPos, plantPos )}' );
				if( !treePositionsMap.exists( plantPos )) {
					return plantPos;
				}
			}
		}

		return Pos.NO_POS;
	}

	public function getIronDistance( pos:Pos ) {
		var closestDistance = boardWidth * boardHeight;
		// printErr( 'ironNeighbors ' + board.ironNeighbors.join( "," ) );
		for( ironNeighborPos in ironNeighbors ) {
			final distance = getDistance( pos, ironNeighborPos );
			// printErr( 'ironNeighbor $ironNeighborPos distance $distance' );
			if( distance == -1 ) printErr( 'Error: no path from pos ${pos} to ironNeighbor $ironNeighborPos' );
			else if( distance < closestDistance ) {
				closestDistance = distance;
			}
		}
		// printErr( 'troll $id closestIronNeighborPos $closestIronNeighborPos' );
		return closestDistance;
	}

	public function getTreeTypeDistances() {
		for( type in treeTypeDistances.keys() ) treeTypeDistances[type] = boardWidth * boardHeight;

		for( tree in trees ) {
			if( tree.type == BANANA ) continue; // ignore bananas
			final distance = getDistance( tree.pos, myShack );
			treeTypeDistances[tree.type] = distance.min( treeTypeDistances[tree.type] );
		}

		return treeTypeDistances;
	}

	public function getTreeTypesAroundBase( maxDepth:Int ) {
		for( type in treeTypesAroundBase.keys() ) treeTypesAroundBase[type] = 0;
		for( depth in 0...maxDepth ) {
			for( treePos in plantPositions[depth] ) {
				if( treePositionsMap.exists( treePos ) ) {
					final tree = treePositionsMap[treePos];
					if( tree.type == BANANA ) continue; // ignore bananas

					treeTypesAroundBase[tree.type]++;
				}
			}
		}
		
		return treeTypesAroundBase;
	}

	public function countTreesAroundBase( maxDepth:Int ) {
		var count = 0;
		for( depth in 0...maxDepth ) {
			for( treePos in plantPositions[depth] ) {
				if( treePositionsMap.exists( treePos ) ) {
					count++;
				}
			}
		}
		
		return count;
	}

	public function getSortedTreesAround( shackPos:Pos, trollPos:Pos ) {
		trees.sort(( a, b ) -> {
			final d1 = getDistance( shackPos, a.pos );
			final d2 = getDistance( shackPos, b.pos );
			if( d1 < d2 ) return -1;
			if( d1 > d2 ) return 1;
				
			final t1 = getDistance( trollPos, a.pos );
			final t2 = getDistance( trollPos, b.pos );
			if( t1 < t2 ) return -1;
			if( t1 > t2 ) return 1;
			
			return 0;
		});
		
		return trees;
	}

	public function getFruitsAroundBase( maxDepth:Int, trollSpeed:Int ) {
		for( fruit in fruitsAroundBase.keys() ) fruitsAroundBase[fruit] = 0;
		for( depth in 0...maxDepth ) {
			for( treePos in plantPositions[depth] ) {
				if( treePositionsMap.exists( treePos ) ) {
					final tree = treePositionsMap[treePos];
					final distance = getDistance( myShack, tree.pos );
					final futureFruits = tree.getFruitsAfter( int( distance / trollSpeed ) );
					
					fruitsAroundBase[tree.type] += futureFruits;
				}
			}
		}

		return fruitsAroundBase;
	}
	
	public function countFruits( fruitTypes:Map<TResource, Int> ) {
		var count = 0;
		for( amount in fruitTypes ) count += amount;
		
		return count;
	}

	public function checkInsideBoard( x:Int, y:Int ) return x >= 0 && x < boardWidth && y >= 0 && y < boardHeight;
	public function checkOutsideBoard( x:Int, y:Int ) return x < 0 || x >= boardWidth || y < 0 || y >= boardHeight;
	
	public function centerDistance( pos:Pos ) return center.manhattanDistance( pos );

	public inline function getCell( pos:Pos ) {
		final cell = grid[pos.y][pos.x];
		return cell;
	}

	public function getWalkableNeighbors( pos:Pos ) {
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final neighborX = pos.x + neighborOffset.x;
			final neighborY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( neighborX, neighborY ) ) continue;
			
			final neighbor = positions[neighborY][neighborX];
			final cell = getCell( neighbor );
			if( cell == WATER || cell == ROCK || cell == IRON ) continue;
			neighbors.push( neighbor );
		}
		return neighbors;
	}

	public function getReacheableNeighbors( pos:Pos, maxDistance:Int ) {
		final neighbors = [];
		final minY = pos.y - maxDistance;
		final maxY = pos.y + maxDistance;
		for( y in minY...maxY + 1 ) {
			if( y < 0 || y >= boardHeight ) continue;
			final dy = IntMath.abs( y - pos.y );
			final remainingDistance = maxDistance - dy;
			final minX = pos.x - remainingDistance;
			final maxX = pos.x + remainingDistance;
			for( x in minX...maxX + 1 ) {
				if( x < 0 || x >= boardWidth ) continue;
				// neighbors.push( positions[y][x] );

				final neighbor = positions[y][x];
				final cell = getCell( neighbor );
				if( cell == WATER || cell == ROCK || cell == IRON ) continue;
				if( neighbor == myShack || neighbor == oppShack ) continue;
				if( occupiedPositions.contains( neighbor )) continue;
				
				neighbors.push( neighbor );
			}
		}
		return neighbors;
	}

	public function getAllNeighbors( pos:Pos ) {
		final neighbors = [];
		for( neighborOffset in neighborOffsets ) {
			final neighborX = pos.x + neighborOffset.x;
			final neighborY = pos.y + neighborOffset.y;
			if( checkOutsideBoard( neighborX, neighborY ) ) continue;
			final neighbor = positions[neighborY][neighborX];
			neighbors.push( neighbor );
		}
		return neighbors;
	}

	public function getDistance( startPos:Pos, endPos:Pos ) {
		final path = getPath( startPos, endPos );
		return path.length - 1;
	}

	public function getPath( startPos:Pos, endPos:Pos ) {
		final startIndex = pos2Index( startPos );
		final endIndex = pos2Index( endPos );
		
		if( paths[startIndex][endIndex].length == 0 ) {
			if( startIndex == endIndex ) {
				final path = [startPos];
				paths[startIndex][endIndex] = path;
				// printErr( 'getPath $startPos -> $endPos: $path' );
				return path;
			}
			
			final solution = map2d.solve( startPos.x, startPos.y, endPos.x, endPos.y );
			
			if( solution.result == Solved ) {
				final path = solution.path.map( point2D -> positions[point2D.y][point2D.x] );
				paths[startIndex][endIndex] = path;
				
				final reversePath = path.copy();
				reversePath.reverse();
				paths[endIndex][startIndex] = reversePath;
				
				// printErr( 'new path $startPos -> $endPos: $path' );
				return path;
			
			} else {
				// printErr( 'getPath $startPos -> $endPos: notfound' );
				return [];
			}
		}

		final path = paths[startIndex][endIndex];
		// printErr( 'getPath $startPos -> $endPos: $path' );
		return path;
	}

	public function outputBoard( board:Array<Array<Int>> ) {
		final output = [for( y in 0...boardHeight )
			[for( x in 0...boardWidth ) {
				final cell = board[y][x];
				switch( cell ) {
					case WATER: return "~";
					case ROCK: return "#";
					case IRON: return "+";
					case MY_SHACK: return "0";
					case OPP_SHACK: return "1";
					default: return ".";
				}
			}].join( "" )
		];
		
		return output.join( "\n" );
	}

	// public function previewNextBoard() {
	// 	for( y in 0...boardHeight ) for( x in 0...boardWidth ) nextBoard[y][x] = grid[y][x];

	// 	return outputBoard( nextBoard );
	// }

	inline function index2Pos( index:Int ) return positions[int( index / boardWidth )][index % boardWidth];
	inline function pos2Index( pos:Pos ) return pos.y * boardWidth + pos.x;

}