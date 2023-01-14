package ai.versions;

import Std.int;
import Std.parseInt;
import ai.IAi;
import game.Adjacency;
import game.Coord.NO_COORD;
import game.Coord;
import game.Tile;
import haxe.Timer;

using Lambda;
using xa3.ArrayUtils;
using xa3.MathUtils;
#if ( localGame && js )
import game.LocalCodinGame.printErr;
import game.LocalCodinGame.readline;
#else
import CodinGame.printErr;
import CodinGame.readline;
#end

class Ai2 implements IAi {
	public var aiId = "Ai2";
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	public var width(default, null):Int;
	public var height(default, null):Int;
	
	final tiles:Array<Tile> = [];
	final coords:Array<Coord> = [];
	final mySideRecyclerCoords:Array<Coord> = [];
	final oppRecyclerCoords:Map<Coord, Bool> = [];
    
	final myUnits:Array<Coord> = [];
	final myUnitCoords:Array<Coord> = [];
    final oppUnitCoords:Array<Coord> = [];
    final myRecyclers:Array<Coord> = [];
    final oppRecyclers:Array<Coord> = [];
    final oppTiles:Map<Coord, Tile> = [];
    final myTiles:Map<Coord, Tile> = [];
    final neutralTiles:Map<Coord, Tile> = [];
	
	final mySideCoords:Map<Coord, Bool> = [];
	final oppSideCoords:Array<Coord> = [];
	final border:Array<Coord> = [];
	final targets:Array<Coord> = [];

	var needsGlobalInputs = true;
	var turn = 0;
	var myMatter = 0;
	var oppMatter = 0;
	
	final actions:Array<String> = [];

	var oppDirectionX = 0;
	var oppDirectionY = 0;

	public function new() { }

	
	public function setGlobalInputs( inputLine:String ) {
		final inputs = inputLine.split( ' ' );
		width = parseInt( inputs[0] );
		height = parseInt( inputs[1] );
		needsGlobalInputs = false;

		for( y in 0...height ) for( x in 0...width ) coords.push( new Coord( x, y ));
	}
	
	function initMap() {
		var myStartPosition = NO_COORD;
		var oppStartPosition = NO_COORD;
		for( coord => tile in myTiles ) if( tile.units == 0 ) myStartPosition = coord;
		for( coord => tile in oppTiles ) if( tile.units == 0 ) oppStartPosition = coord;
		oppDirectionX = oppStartPosition.x > myStartPosition.x ? 1 : -1;
		oppDirectionY = oppStartPosition.y > myStartPosition.y ? 1 : -1;
		final startDistance = myStartPosition.manhattanToCoord( oppStartPosition );
		final offset = startDistance % 2 == 0 ? 0 : 1;
		
		for( tile in tiles ) {
			final coord = coordFromTile( tile );
			final myDistance = myStartPosition.manhattanTo( tile.x, tile.y );
			final oppDistance = oppStartPosition.manhattanTo( tile.x, tile.y );
			if( myDistance == oppDistance - offset && tile.scrapAmount > 0 ) {
				final tile = coordFromTile( tile );
				border.push( tile );
				targets.push( tile );
			}
			if( myDistance <= oppDistance ) mySideCoords.set( coord, true );
			else oppSideCoords.push( coord );
			
			final neighbors = getValidNeighborTiles( coord, Adjacency.FOUR );
			var lowerNeighbors = 0;
			var higherNeighbors = 0;
			for( neighbor in neighbors ) {
				if( neighbor.scrapAmount < tile.scrapAmount ) lowerNeighbors++;
				if( neighbor.scrapAmount > tile.scrapAmount ) higherNeighbors++;
			}
			final isMySide = myDistance <= oppDistance;
			if( higherNeighbors >= 3 && isMySide) mySideRecyclerCoords.push( coord );
			if( lowerNeighbors >= 3 && !isMySide) oppRecyclerCoords.set( coord, true );
		}

		mySideRecyclerCoords.sort(( a, b ) -> a.manhattanToCoord( myStartPosition ) - b.manhattanToCoord( myStartPosition ));

		for( i in 0...8 ) if( mySideRecyclerCoords.length > i ) {
			targets.push( mySideRecyclerCoords[i] );
			// trace( 'my recycler coord ${mySideRecyclerCoords[i]}' );
		}
		// trace( 'targets $targets' );
		// trace( 'startDistance $startDistance  myStartPosition $myStartPosition  opStartPosition $oppStartPosition\n$border' );
	}
	
	function xyIndex( x:Int, y:Int ) return y * width + x;
	function coordFromTile( tile:Tile ) return coords[xyIndex( tile.x, tile.y )];
	function tileFromCoord( coord:Coord ) return tiles[xyIndex( coord.x, coord.y )];
	function getValidNeighborTiles( coord:Coord, adjacency:Array<Coord> ) {
		final neighborTiles = [];
		for( delta in adjacency ) {
			final neighborCoord = coord.addCoord( delta );
			if( neighborCoord.x >= 0 && neighborCoord.x < width && neighborCoord.y >= 0 && neighborCoord.y < height ) {
				final tile = tileFromCoord( neighborCoord );
				if( tile.scrapAmount > 0 && !tile.recycler ) neighborTiles.push( tile );
			}
		}
		return neighborTiles;
	}
	
	public function setInputs( inputLines:Array<String> ) {
		#if localGame
		if( needsGlobalInputs ) setGlobalInputs( inputLines.shift());
		#end
		// trace( 'setInputs ai $aiId\n${inputLines.join("\n")}' );
		final inputs = inputLines[0].split(" ");
		myMatter = parseInt( inputs[0] );
		oppMatter = parseInt( inputs[1] );
		
		resetTiles();
		var i = 1;
		for( y in 0...height ) {
			for( x in 0...width ) {
				final inputs = inputLines[i++].split(" ");
				
				final index = xyIndex( x, y );
				final coord = coords[index];
				
				final tile:Tile = {
					x: x,
					y: y,
					scrapAmount: parseInt( inputs[0] ),
					owner: parseInt( inputs[1] ),
					units: parseInt( inputs[2] ),
					recycler: parseInt( inputs[3] ) == 1,
					canBuild: parseInt( inputs[4] ) == 1,
					canSpawn: parseInt( inputs[5] ) == 1,
					inRangeOfRecycler: parseInt( inputs[6] ) == 1
				}
				tiles[index] = tile;
				if( tile.owner == ME ) {
					myTiles.set( coord, tile );
					for( _ in 0...tile.units ) myUnits.push( coord );
					if( tile.units > 0 ) myUnitCoords.push( coord );
					else if( tile.recycler ) myRecyclers.push( coord );
				} else if( tile.owner == OPP ) {
					oppTiles.set( coord, tile );
					if( tile.units > 0 ) oppUnitCoords.push( coord );
					if( tile.recycler ) oppRecyclers.push( coord );
				} else {
					neutralTiles.set( coord, tile );
				}
			}
		}
		
		oppUnitCoords.sort(( a, b ) -> {
			if( a.x * oppDirectionX < b.x * oppDirectionX ) return -1;
			if( a.x * oppDirectionX > b.x * oppDirectionX ) return 1;
			return 0;
		});
		// if( turn == 1 ) trace( oppUnitCoords.join(",") );
		if( turn == 0 ) initMap();
	}
	
	function resetTiles() {
		myUnits.clear();
		myUnitCoords.clear();
		oppUnitCoords.clear();
		myRecyclers.clear();
		oppRecyclers.clear();
		oppTiles.clear();
		myTiles.clear();
		neutralTiles.clear();
	}


	public function process() {
		final start = Timer.stamp();
		actions.clear();
		
		expand();
		
		final duration = int(( Timer.stamp() - start ) * 1000 );
		final output = ( actions.length == 0 ? "WAIT" : actions.join( ";" )) + ';MESSAGE ${duration}ms';
		#if localGame
		printErr( '$turn $output MESSAGE ${duration}ms' );
		#end
		
		turn++;
		return output;
	}

	function expand() {
		final freeUnits = [for( unit in myUnits ) unit => true];

		// evade removal by recycler
		for( unit in myUnitCoords ) {
			final tile = tileFromCoord( unit );
			// if( turn == 10 && unit.x == 5 && unit.y == 2 ) trace( tile );
			if( tile.inRangeOfRecycler && tile.scrapAmount == 1 ) {
				targets.remove( unit );
				// trace( '$turn unit $unit  remove target $unit' );
				final neighbors = getValidNeighborTiles( unit, Adjacency.FOUR );
				neighbors.sort(( a, b ) -> {
					if( a.scrapAmount < b.scrapAmount ) return -1;
					if( a.scrapAmount > b.scrapAmount ) return 1;
					return 0;
				});
				
				for( neighbor in neighbors ) {
					if( neighbor.scrapAmount > 0 ) {
						// trace( '$turn move $unit to ${neighbor.x}:${neighbor.y} to evade recycler' );
						actions.push( 'MOVE ${tile.units} ${unit.x} ${unit.y} ${neighbor.x} ${neighbor.y}' );
						freeUnits.remove( unit );
					}
					break;
				}
			}
		}
		
		for( i in -targets.length + 1...1 ) {
			final coord = targets[-i];
			final index = xyIndex( coord.x, coord.y );
			if( tiles[index].scrapAmount == 0 || tiles[index].recycler ) {
				targets.remove( coord );
			}
		};
		
		final targetPriorities = [];
		for( target in targets ) {
			final tile = tileFromCoord( target );
			var distanceOppUnits = width + height;
			var oppUnitsNum = 0;
			for( oppUnit in oppUnitCoords ) {
				final distance = target.manhattanToCoord( oppUnit );
				if( distance < distanceOppUnits ) {
					distanceOppUnits = distance;
					final oppTile = tileFromCoord( oppUnit );
					oppUnitsNum = oppTile.units;
				}
			}
			var distanceMyUnits = width + height;
			var myUnitsNum = 0;
			for( myUnit in myUnitCoords ) {
				final distance = target.manhattanToCoord( myUnit );
				if( distance < distanceMyUnits ) {
					distanceMyUnits = distance;
					final myTile = tileFromCoord( myUnit );
					myUnitsNum = myTile.units;
				}
			}
			targetPriorities.push({ target: target, owner: tile.owner, distanceOppUnits: distanceOppUnits, oppUnitsNum: oppUnitsNum, distanceMyUnits: distanceMyUnits, myUnitsNum: myUnitsNum });
		}
		targetPriorities.sort(( a, b ) -> {
			// if( a.owner == ME && b.owner != ME ) return -1;
			// if( a.owner != ME && b.owner == ME ) return 1;
			
			if( a.distanceOppUnits < b.distanceOppUnits ) return -1;
			if( a.distanceOppUnits > b.distanceOppUnits ) return 1;
			
			if( a.distanceMyUnits < b.distanceMyUnits ) return 1;
			if( a.distanceMyUnits > b.distanceMyUnits ) return -1;
			
			if( a.oppUnitsNum < b.oppUnitsNum ) return 1;
			if( a.oppUnitsNum > b.oppUnitsNum ) return -1;
			
			if( a.myUnitsNum < b.myUnitsNum ) return 1;
			if( a.myUnitsNum > b.myUnitsNum ) return -1;
			return 0;
		});
		if( turn < 10 ) for( tp in targetPriorities) trace( 'target: ${tp.target}, owner: ${tp.owner}, distanceOppUnits: ${tp.distanceOppUnits}, oppUnitsNum: ${tp.oppUnitsNum}, distanceMyUnits: ${tp.distanceMyUnits}, myUnitsNum: ${tp.myUnitsNum}' );
		// final ttext = [for( tp in targetPriorities) '{${tp.target}, ${tp.distance}, ${tp.units}}'];
		// trace( '$turn targets ${ttext.join(", ")}' );

		if( myMatter >= 10 ) {
			// Build
			var foundBuildTile = false;
			for( coord in mySideRecyclerCoords ) {
				final tile = tileFromCoord( coord );
				// trace( 'check tile ${tile.x}:${tile.y} owner ${tile.owner == ME} canBuild ${tile.canBuild}' );
				if( tile.owner == ME && tile.canBuild && myRecyclers.length < 4 ) {
					actions.push( 'BUILD ${tile.x} ${tile.y}' );
					myMatter -= 10;
					foundBuildTile = true;
					myRecyclers.push( coord );
					break;
				}
			}

			// Spawn
			var minDistance = width + height;
			var closestCoord = NO_COORD;
			for( coord => tile in myTiles ) {
				if( tile.canSpawn ) {
					for( tp in targetPriorities ) {
						final distance = coord.manhattanToCoord( tp.target );
						if( distance < minDistance ) {
							minDistance = distance;
							closestCoord = tp.target;
						}
					}
				}
			}
			while( myMatter >= 10 ) {
				if( closestCoord == NO_COORD ) break;
				actions.push( 'SPAWN 1 ${closestCoord.x} ${closestCoord.y}' );
				myMatter -= 10;
			}
		}

		// move to border
		for( tp in targetPriorities ) {
			for( _ in 0...tp.oppUnitsNum ) {
				var minDistance = width + height;
				var closestUnit = NO_COORD;
				for( unit in freeUnits.keys() ) {
					final distance = unit.manhattanToCoord( tp.target );
					if( distance < minDistance ) {
						minDistance = distance;
						closestUnit = unit;
					}
				}
				if( minDistance == 0 ) freeUnits.remove( closestUnit );
				else if( closestUnit != NO_COORD ) {
					actions.push( 'MOVE 1 ${closestUnit.x} ${closestUnit.y} ${tp.target.x} ${tp.target.y}' );
					freeUnits.remove( closestUnit );
				}
			}
		}

		for( unit in freeUnits.keys()) roam( unit );
		// final f = [for( u in freeUnits.keys() ) u];
		// trace( '$turn free units $f' );
	}

	function roam( unit:Coord ) {
		// if( mySideCoords.length == 0 ) return;
		
		coords.sort(( a, b ) -> {
			final da = unit.manhattanToCoord( a );
			final db = unit.manhattanToCoord( b );
			if( da < db ) return -1;
			if( da > db ) return 1;
			return 0;
		});
		for( coord in coords ) {
			final tile = tileFromCoord( coord );
			if( tile.owner != ME && tile.scrapAmount > 0 ) {
				actions.push( 'MOVE 1 ${unit.x} ${unit.y} ${coord.x} ${coord.y}' );
				// printErr( '$turn MOVE 1 ${unit.x} ${unit.y} ${coord.x} ${coord.y}' );
				break;
			}
		}
	}
}
