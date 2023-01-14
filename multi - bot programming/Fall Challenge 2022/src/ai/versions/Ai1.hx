package ai.versions;

#if ( localGame && js )
import game.LocalCodinGame.printErr;
import game.LocalCodinGame.readline;
#else
import CodinGame.printErr;
import CodinGame.readline;
#end
import Std.int;
import Std.parseInt;
import ai.IAi;
import game.Adjacency;
import game.Coord.NO_COORD;
import game.Coord;
import game.Tile;

using Lambda;
using xa3.ArrayUtils;
using xa3.MathUtils;

class Ai1 implements IAi {
	public var aiId = "Ai1";
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	public var width(default, null):Int;
	public var height(default, null):Int;
	
	final tiles:Array<Tile> = [];
	final coords:Array<Coord> = [];
    final myUnits:Array<Coord> = [];
    final oppUnits:Array<Coord> = [];
    final myRecyclers:Array<Coord> = [];
    final oppRecyclers:Array<Coord> = [];
    final oppTiles:Map<Coord, Tile> = [];
    final myTiles:Map<Coord, Tile> = [];
    final neutralTiles:Map<Coord, Tile> = [];
	
	final mySideRecyclerCoords:Array<Coord> = [];
	final oppRecyclerCoords:Map<Coord, Bool> = [];
	final mySideCoords:Map<Coord, Bool> = [];
	final oppSideCoords:Array<Coord> = [];
	final border:Array<Coord> = [];
	final targets:Array<Coord> = [];

	var needsGlobalInputs = true;
	var turn = 0;
	var myMatter = 0;
	var oppMatter = 0;
	
	final actions:Array<String> = [];

	var centerX:Int;
	var centerY:Int;

	var state = Expand;

	var oppDirectionX = 0;
	var oppDirectionY = 0;

	public function new() { }

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
					if( tile.recycler ) myRecyclers.push( coord );
				} else if( tile.owner == OPP ) {
					oppTiles.set( coord, tile );
					if( tile.units > 0 ) oppUnits.push( coord );
					if( tile.recycler ) oppRecyclers.push( coord );
				} else {
					neutralTiles.set( coord, tile );
				}
			}
		}
		if( turn == 0 ) initMap();
	}
	
	public function setGlobalInputs( inputLine:String ) {
		final inputs = inputLine.split( ' ' );
		width = parseInt( inputs[0] );
		height = parseInt( inputs[1] );
		needsGlobalInputs = false;

		for( y in 0...height ) for( x in 0...width ) coords.push( new Coord( x, y ));
	}
	
	function resetTiles() {
		myUnits.clear();
		oppUnits.clear();
		myRecyclers.clear();
		oppRecyclers.clear();
		oppTiles.clear();
		myTiles.clear();
		neutralTiles.clear();
	}

	function xyIndex( x:Int, y:Int ) return y * width + x;
	function coordFromTile( tile:Tile ) return coords[xyIndex( tile.x, tile.y )];
	function tileFromCoord( coord:Coord ) return tiles[xyIndex( coord.x, coord.y )];
	function getNeighborTiles( coord:Coord, adjacency:Array<Coord> ) {
		final neighborTiles = [];
		for( delta in adjacency ) {
			final neighborCoord = coord.addCoord( delta );
			if( neighborCoord.x >= 0 && neighborCoord.x < width && neighborCoord.y >= 0 && neighborCoord.y < height ) {
				neighborTiles.push( tileFromCoord( neighborCoord ));
			}
		}
		return neighborTiles;
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
			
			final neighbors = getNeighborTiles( coord, Adjacency.FOUR );
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

		centerX = int( width / 2 );
		centerY = int( height / 2 );
		
		for( i in 0...8 ) if( mySideRecyclerCoords.length > i ) {
			targets.push( mySideRecyclerCoords[i] );
			// trace( 'my recycler coord ${mySideRecyclerCoords[i]}' );
		}
		// trace( 'targets $targets' );
		// trace( 'startDistance $startDistance  myStartPosition $myStartPosition  opStartPosition $oppStartPosition\n$border' );
	}

	public function process() {
		actions.clear();
		
		printErr( '$turn ' + myUnits.join( ", " ));

		if( state == Expand ) expand();
		else raid();
		
		final output = actions.length == 0 ? "WAIT" : actions.join( ";" );
		#if localGame
		printErr( '$turn $output' );
		#end
		
		turn++;
		return output;
	}

	function expand() {
		if( myMatter >= 10 ) {
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
			// if( !foundBuildTile ) trace( 'no build tile found ' );
		}
		

		for( i in -targets.length + 1...1 ) {
			final coord = targets[-i];
			final index = xyIndex( coord.x, coord.y );
			if( myTiles.exists( coord ) || tiles[index].scrapAmount == 0 || tiles[index].recycler ) {
				targets.remove( coord );
			}
		};
		
		final expandTargets = targets.copy();
		for( oppUnit in oppUnits ) {
			if( mySideCoords.exists( oppUnit )) expandTargets.push( oppUnit );
		}
		
		final targetPriorities = [];
		for( target in expandTargets ) {
			var minDistance = width + height;
			for( oppUnit in oppUnits ) {
				final distance = target.manhattanToCoord( oppUnit );
				if( distance < minDistance ) {
					minDistance = distance;
					if( distance == 0 ) break;
				}
			}
			targetPriorities.push({ target: target, priority: 1 / ( minDistance + 1 )});
		}

		final unitTargetPairs = [];
		for( u in myUnits ) {
			for( tb in targetPriorities ) {
				final distancePriority = 1 / ( u.dist2To( tb.target.x, tb.target.y )) + 1;
				final priority = distancePriority * tb.priority;
				unitTargetPairs.push({ unit: u, targetCoord: tb.target, priority: priority });
			}
		}
		
		unitTargetPairs.sort(( a, b ) -> {
			if( a.priority < b.priority ) return 1;
			if( a.priority > b.priority ) return -1;
			return 0;
		});
		// printErr( unitTargetPairs );
		
		final freeUnits = [for( unit in myUnits ) unit => true];
		final targetedCoords:Map<Coord, Bool> = [];
		for( pair in unitTargetPairs ) {
			if( freeUnits.exists( pair.unit ) && !targetedCoords.exists( pair.targetCoord )) {
				actions.push( 'MOVE 1 ${pair.unit.x} ${pair.unit.y} ${pair.targetCoord.x} ${pair.targetCoord.y}' );
				freeUnits.remove( pair.unit );
				targetedCoords.set( pair.targetCoord, true );
			}
		}

		for( unit in freeUnits.keys()) roam( unit );
		// printErr( '$turn myUnits ${myUnits.length}  myRecyclers ${myRecyclers.length}  expandTargets ${expandTargets.length}' );
		if( expandTargets.length == 0 ) switchToRaid();
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

	function switchToRaid() {
		state = Raid;
		printErr( 'turn $turn switchToRaid' );
	}

	function raid() {
		if( myMatter >= 10 ) {
			var foundBuildTile = false;
			for( coord in oppRecyclerCoords.keys() ) {
				final tile = tileFromCoord( coord );
				// trace( 'check tile ${tile.x}:${tile.y} owner ${tile.owner == ME} canBuild ${tile.canBuild}' );
				if( tile.owner == ME && tile.canBuild ) {
					actions.push( 'BUILD ${tile.x} ${tile.y}' );
					myMatter -= 10;
					foundBuildTile = true;
					break;
				}
			}
		}
		final unitTargetPairs = [for( u in myUnits ) for( b in targets ) { unit: u, targetCoord: b, distance: u.dist2To( b.x, b.y ) }];
		unitTargetPairs.sort(( a, b ) -> a.distance - b.distance );
		
		final freeUnits = [for( unit in myUnits ) unit => true];
		final targetedCoords:Map<Coord, Bool> = [];
		for( pair in unitTargetPairs ) {
			if( freeUnits.exists( pair.unit ) && !targetedCoords.exists( pair.targetCoord )) {
				actions.push( 'MOVE 1 ${pair.unit.x} ${pair.unit.y} ${pair.targetCoord.x} ${pair.targetCoord.y}' );	
				freeUnits.remove( pair.unit );
				targetedCoords.set( pair.targetCoord, true );
			}
		}
		for( unit in freeUnits.keys()) roam( unit );
		
	}
}

enum State {
	Expand;
	Raid;
}