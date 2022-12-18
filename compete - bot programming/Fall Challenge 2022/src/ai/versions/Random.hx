package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import game.Tile;

using Lambda;
using xa3.ArrayUtils;
using xa3.MathUtils;

class Random implements IAi {
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	public var aiId = "Random";
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
		
		// trace( 'setInputs ai $aiId\n${inputLines.join("\n")}' );
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
		trace( 'process ai $aiId' );
		actions.clear();
		
		for( tile in myTiles ) {
			if( tile.canSpawn ) {
				final amount = 0;
				if( amount > 0 ) {
					actions.push( 'SPAWN $amount ${tile.x} ${tile.y}' );
				}
			}
			if( tile.canBuild ) {
				final shouldBuild = false;
				if( shouldBuild ) {
					actions.push( 'BUILD ${tile.x} ${tile.y}' );
				}
			}
		}

		for( tile in myUnits ) {
			final target = tiles[Std.random( tiles.length )];
			if( target != null ) {
				final amount = 1;
				actions.push( 'MOVE $amount ${tile.x} ${tile.y} ${target.x} ${target.y}' );
			}
		}

		return actions.length == 0 ? "WAIT" : actions.join( ";" );
	}
}
