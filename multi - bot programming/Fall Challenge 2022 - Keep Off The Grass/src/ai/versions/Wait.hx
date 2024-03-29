package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import game.Tile;

using Lambda;
using xa3.ArrayUtils;
using xa3.MathUtils;

class Wait implements IAi {
	public var aiId = "Wait";
	
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
	
	public function process() return "WAIT";
}
