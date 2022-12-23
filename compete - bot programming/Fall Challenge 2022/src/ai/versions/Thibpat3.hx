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

class Thibpat3 implements IAi {
	public var aiId = "Thibpat_2";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	public var width(default, null):Int;
	public var height(default, null):Int;

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
	var myMatter = 0;
	var oppMatter = 0;

	var turn = 0;
	final endOfEarlyGame = 6;

	public function new() { }
	
	public function setInputs( inputLines:Array<String> ) {
		#if localGame
		if( needsGlobalInputs ) setGlobalInputs( inputLines.shift());
		#end
		
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
	
	public function setGlobalInputs( inputLine:String ) {
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

		if( turn < endOfEarlyGame && myMatter >= 10 ) {
			final recyclerTiles = myTiles.map( tile -> {
				var recyclerScore = 0;
				if( tile.canBuild ) {
					var totalScrap = 0;
					final maxRecycler = tile.scrapAmount;
					totalScrap += maxRecycler;
					if( tile.y > 0 ) {
						var upperTile = tiles[pos2Index( tile.x, tile.y - 1 )];
						totalScrap += MathUtils.min( upperTile.scrapAmount, maxRecycler );
						if( upperTile.recycler ) totalScrap -= 100;
					}
					if( tile.x > 0 ) {
						var leftTile = tiles[pos2Index( tile.x - 1, tile.y )];
						totalScrap += MathUtils.min( leftTile.scrapAmount, maxRecycler );
						if( leftTile.recycler ) totalScrap -= 100;
					}
					if( tile.y < height - 1 ) {
						var lowerTile = tiles[pos2Index( tile.x, tile.y + 1 )];
						totalScrap += MathUtils.min( lowerTile.scrapAmount, maxRecycler );
						if( lowerTile.recycler ) totalScrap -= 100;
					}
					if( tile.x < width - 1 ) {
						var rightTile = tiles[pos2Index( tile.x + 1, tile.y )];
						totalScrap += MathUtils.min( rightTile.scrapAmount, maxRecycler );
						if( rightTile.recycler ) totalScrap -= 100;
					}
					recyclerScore = totalScrap;
				}
				// printErr( '$turn tile ${tile.x}:${tile.y}  recyclerScore $recyclerScore' );
				return { tile: tile, recyclerScore: recyclerScore }
			});
			
			recyclerTiles.sort(( a, b ) -> b.recyclerScore - a.recyclerScore );
			if( recyclerTiles.length > 0 && recyclerTiles[0].recyclerScore >= 1 ) {
				myMatter -= 10;
				actions.push( 'BUILD ${recyclerTiles[0].tile.x} ${recyclerTiles[0].tile.y}' );
			}
		}

		final targetTiles = oppTiles.filter( tile -> !tile.recycler )
		.concat( neutralTiles.filter( t -> t.scrapAmount > 0 ));

		final spawnTiles = myTiles.filter( tile -> tile.canSpawn );
		if( spawnTiles.length > 0 && myMatter >= 10 ) {
			final tilesWithScore = spawnTiles.map( tile -> {
				final distances = targetTiles.map( target -> distance( tile, target ));
				final spawnScore = distances.sum() / distances.length;
				return { tile:tile, spawnScore: spawnScore }
			});
			tilesWithScore.sort(( a, b ) -> {
				if( a.spawnScore < b.spawnScore ) return -1;
				if( a.spawnScore > b.spawnScore ) return 1;
				return 0;
			});

			while( turn >= endOfEarlyGame && spawnTiles.length > 0 && myMatter >= 10 ) {
				final spawnTile = tilesWithScore.shift().tile;
				actions.push( 'SPAWN 1 ${spawnTile.x} ${spawnTile.y}' );
				myMatter -= 10;
			}
		}

		for( tile in myUnits ) {
			if( targetTiles.length > 0 ) {
				targetTiles.sort(( a, b ) -> distance( tile, a ) - distance( tile, b ));
				final target = targetTiles.shift();
				// printErr( 'units on ${tile.x}:${tile.y} target $target' );
				final amount = max( tile.units - 1, 1 );
				actions.push( 'MOVE $amount ${tile.x} ${tile.y} ${target.x} ${target.y}' );
			}
		}

		turn++;
		return actions.length == 0 ? "WAIT" : actions.join( ";" );
	}

	function distance( a:Tile, b:Tile ) return abs( a.x - b.x ) + abs( a.y - b.y );
	function pos2Index( x:Int, y:Int ) return y * width + x;
}
