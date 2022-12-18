package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import game.Tile;
import xa3.MathUtils.abs;
import xa3.MathUtils.max;

using Lambda;
using xa3.ArrayUtils;
using xa3.MathUtils;

class Thibpat01 implements IAi {
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	public var aiId = "Thibpat01";
	public var width:Int;
	public var height:Int;

	var myMatter = 0;
	var oppMatter = 0;
	final tiles:Array<Tile> = [];
    final myUnits:Array<Tile> = [];
    final oppUnits:Array<Tile> = [];
    final myRecyclers:Array<Tile> = [];
    final oppRecyclers:Array<Tile> = [];
    final oppTiles:Array<Tile> = [];
    final myTiles:Array<Tile> = [];
    final neutralTiles:Array<Tile> = [];

	final actions:Array<String> = [];

	var needsGlobalInputs = true;

	public function new() { }
	
	public function setInputs( inputLines:Array<String> ) {
		if( needsGlobalInputs ) setGlobalInputs( inputLines.shift());

		final inputs = inputLines[0].split(" ");
		myMatter = parseInt( inputs[0] );
		oppMatter = parseInt( inputs[1] );
		
		resetTiles();
		var i = 1;
		for( y in 0...height ) {
			for( x in 0...width ) {
				final inputs = inputLines[i++].split(" ");
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
				tiles.push( tile );

				if( tile.owner == ME ) {
					myTiles.push( tile );
					if( tile.units > 0 ) myUnits.push( tile );
					else if( tile.recycler ) myRecyclers.push( tile );
				} else if( tile.owner == OPP ) {
					oppTiles.push( tile );
					if( tile.units > 0 ) oppUnits.push( tile );
					else if( tile.recycler ) oppRecyclers.push( tile );
				} else {
					neutralTiles.push( tile );
				}
			}
		}
	}
	
	function setGlobalInputs( inputLine:String ) {
		final inputs = inputLine.split( ' ' );
		width = parseInt( inputs[0] );
		height = parseInt( inputs[1] );
		needsGlobalInputs = false;
	}
	
	function resetTiles() {
		tiles.clear();
		myUnits.clear();
		oppUnits.clear();
		myRecyclers.clear();
		oppRecyclers.clear();
		oppTiles.clear();
		myTiles.clear();
		neutralTiles.clear();
	}
	
	public function process() {
		actions.clear();

		final targetTiles = oppTiles.concat( neutralTiles.filter( t -> t.scrapAmount > 0 ));

		final spawnTiles = myTiles.filter( tile -> tile.canSpawn );
		if( spawnTiles.length > 0 && myMatter >= 10 ) {
			final tilesWithScore:Array<TileSpawnScore> = spawnTiles.map( tile -> {
				final distances = targetTiles.map ( target -> distance( tile, target ));
				final spawnScore = distances.sum() / distances.length;
				return { tile:tile, spawnScore: spawnScore }
			});
			tilesWithScore.sort(( a, b ) -> {
				if( a.spawnScore < b.spawnScore ) return -1;
				if( a.spawnScore > b.spawnScore ) return 1;
				return 0;
			});
			
			final spawnTile = tilesWithScore.first().tile;
			final amount = 1;
			actions.push( 'SPAWN $amount ${spawnTile.x} ${spawnTile.y}' );
			myMatter -= 10;
		}

		for( tile in myUnits ) {
			if( targetTiles.length > 0 ) {
				targetTiles.sort(( a, b ) -> distance( tile, a ) - distance( tile, b ));
				final target = targetTiles.first();
				final amount = max( tile.units - 1, 1 );
				actions.push( 'MOVE $amount ${tile.x} ${tile.y} ${target.x} ${target.y}' );
			}
		}

		return actions.length == 0 ? "WAIT" : actions.join( ";" );
	}

	function distance( a:Tile, b:Tile ) {
		return abs( a.x - b.x ) + ( a.y - b.y );
	}
}
