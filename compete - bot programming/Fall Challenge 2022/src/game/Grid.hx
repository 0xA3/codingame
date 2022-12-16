package game;

import Std.int;
import game.Coord;
import haxe.ds.GenericStack;
import haxe.ds.HashMap;
import xa3.MTRandom;

using Lambda;
using xa3.ArrayUtils;

class Grid {
	
	static final NO_HASHMAP = new HashMap<Coord, Bool>();

	public var width:Int;
	public var height:Int;
	public var cells = new HashMap<Coord, Cell>();
	public var cellsNum = 0;
	final random:MTRandom;
	final ySymmetry:Bool;
	public final spawns:Array<Array<Coord>> = [];
	final snaky:Bool;	

	public function new( random:MTRandom, players:Array<Player> ) {
		this.random = random;
		snaky = random.nextFloat() < 0.1;
		width = randInt( Config.MAP_MIN_WIDTH, Config.MAP_MAX_WIDTH + 1 );
		height = int( width * Config.MAP_ASPECT_RATIO );

		ySymmetry = random.nextBool();

		final possibleSpawnPoints:Array<Coord> = [];
		final emptyCells:Array<Coord> = [];

		final center = new Coord( int( width / 2 ), int( height / 2 ));
		cells.clear();
		cellsNum = 0;
		for( y in 0...height ) {
			for( x in 0...width ) {
				final coord = new Coord( x, y );

				if( cells.exists( coord )) continue;

				final durability = randomDurability( x, y, center );
				final cell = new Cell( durability );
				cells.set( coord, cell );
				cellsNum++;

				if( durability == 0 ) emptyCells.push( coord );

				final opposite = opposite( coord );
				if( !opposite.equals( coord )) {
					cells.set( opposite, Cell.fromCell( cell ));
					cellsNum++;
					if(
						durability == Config.CELL_MAX_DURABILITY && x > 1 && y > 1 && x < width - 1 && y < height - 1
							&& coord.manhattanToCoord( opposite ) >= Config.MIN_SPAWN_DISTANCE
							&& coord.manhattanToCoord( opposite ) >= ( width * 0.5 )
					 ) {
						possibleSpawnPoints.push( coord );
					}
				}
			}
		}

		if( possibleSpawnPoints.length == 0 ) possibleSpawnPoints.push( new Coord( 1, 1 ));
		
		final cellIdx = randInt( 0, possibleSpawnPoints.length );
		final spawnPoint = possibleSpawnPoints[cellIdx];
		final opposite = opposite( spawnPoint );

		final spawnPoints:Array<Coord> = random.nextBool()
			? [spawnPoint, opposite]
			: [opposite, spawnPoint];

		for( playerIdx in 0...players.length ) {
			final unitSpawns:Array<Coord> = [];

			final player = players[playerIdx];
			final spawn = spawnPoints[playerIdx];
			final spawncenter = cells.get( spawn );
			spawncenter.owner = player;
			spawncenter.garanteeNotHole();

			getCoordsAround( spawn ).iter( coord -> {
				final cell = cells.get( coord );
				cell.garanteeNotHole();
				cell.owner = player;
				unitSpawns.push( coord );
			} );

			spawns.push( unitSpawns );
		}

		final allSpawns = spawns.flatten();
		for( spawn in allSpawns ) emptyCells.remove( spawn );

		fixIslands( emptyCells );
	}

	function detectIslands() {
		final islands:Array<HashMap<Coord, Bool>> = [];
		final computed = new HashMap<Coord, Bool>();
		final current = new HashMap<Coord, Bool>();

		for( p in cells.keys()) {
			if( getCoord( p ).isHole() ) continue;
			
			if( !computed.exists( p )) {
				final fifo = new List<Coord>();
				fifo.add( p );
				computed.set( p, true );

				while( !fifo.isEmpty()) {
					final e = fifo.pop();
					for( delta in Adjacency.FOUR ) {
						final n = e.addCoord( delta );
						final cell = getCoord( n );
						if( cell.isValid && !cell.isHole() && !computed.exists( n )) {
							fifo.add( n );
							computed.set( n, true );
						}
					}
					current.set( e, true );
				}
				islands.push( current );
				current.clear();
			}
		}

		return islands;
	}

	function closeIslandGap( emptyCells:Array<Coord>, islands:Array<HashMap<Coord,Bool>> ) {
		var connectingIslands:Array<HashMap<Coord,Bool>> = [];
		var bridge:Coord = Coord.NO_COORD;

		for( coord in emptyCells ) {
			final neighs = getNeighbors( coord );
			final connectingIslands = new Array<HashMap<Coord, Bool>>();
			for( neigh in neighs ) {
				final islandFromNeigh = getIslandFrom( islands, neigh );
				if( islandFromNeigh != NO_HASHMAP  && !connectingIslands.contains( islandFromNeigh )) {
					connectingIslands.push( islandFromNeigh );
				}
			}

			if( connectingIslands.length > 1 ) {
				bridge = coord;
				break;
			}
		}

		if( bridge != Coord.NO_COORD ) {
			final bridging = connectingIslands;
			final coord = bridge;
			final opposite = opposite( coord );

			getCoord( coord ).durability = 6;
			getCoord( opposite ).durability = 6;

			emptyCells.remove( coord );
			emptyCells.remove( opposite );

			final newIslands = new List<HashMap<Coord, Bool>>();
			for( set in islands ) if( !bridging.contains( set )) newIslands.add( set );

			final newIsland = new HashMap<Coord, Bool>();
			for( set in bridging ) {
				for( coord in set.keys()) newIsland.set( coord, true );
			}

			islands.splice( 0, islands.length );
			for( island in newIslands ) islands.push( island );
			islands.push( newIsland );
			return true;
		}
		
		return false;
	}

	function fixIslands( emptyCells:Array<Coord> ) {
		emptyCells.shuffle( random );
		final islands = detectIslands();

		while( islands.length > 1 ) {
			final closed = closeIslandGap( emptyCells, islands );
			if( !closed ) {
				break;
			}
		}
	}

	function getIslandFrom( islands:Array<HashMap<Coord, Bool>>, coord:Coord ) {
		for( map in islands ) if( map.exists( coord )) return map;
		return NO_HASHMAP;
	}

	function randomDurability( x:Int, y:Int, center:Coord ) {
		final dist = new Coord( x, y ).manhattanToCoord( center );
		final maxDist = center.manhattanTo( 0, 0 );
		var d = random.nextFloat();
		d *= d;
		final n = 1 / ( 1 + ( 1 - ( dist / maxDist )) * 3 );
		d = Math.pow( d, n );

		if( d < .15 ) return 0;
		if( d < .35 ) return snaky ? 0 : 4;
		if( d < .5 ) return 6;
		if( d < .8 ) return 8;
		if( d < .9 ) return 9;
		
		return Config.CELL_MAX_DURABILITY;
	}

	function getCoordsAround( c:Coord ) {
		return Adjacency.FOUR.map( delta -> c.addCoord( delta ));
	}

	function opposite( c:Coord ) {
		return new Coord( width - c.x - 1, ySymmetry ? ( height - c.y - 1 ) : c.y );
	}

	function randInt( from:Int, to:Int ) return random.nextInt( to - from ) + from;

	public function isYSymetric() return ySymmetry;

	public function getNeighbors( pos:Coord ) {
		final neighs:Array<Coord> = [];
		for( delta in Adjacency.FOUR ) {
			final n = pos.addCoord( delta );
			if( getCoord( n ).isValid ) {
				neighs.push( n );
			}
		}
		return neighs;
	}

	public function getCoord( n:Coord ) {
		return cells.exists( n ) ? cells[n] : Cell.NO_CELL;
	}

	public function get( x:Int, y:Int ) {
		return getCoord( new Coord( x, y ));
	}

	public function isOwner( coord:Coord, player:Player ) {
		return getCoord( coord ).isOwnedBy( player );
	}

	public function getClosestTarget( from:Coord, targets:List<Coord> ) {
		final closest = new List<Coord>();
		var closestBy = 0;
		for( neigh in targets ) {
			final distance = from.manhattanToCoord( neigh );
			if( closest.isEmpty() || closestBy > distance ) {
				closest.clear();
				closest.add( neigh );
				closestBy = distance;
			} else if( !closest.isEmpty() && closestBy == distance ) {
				closest.add( neigh );
			}
		}
		return closest;
	}
}