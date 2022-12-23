package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import game.Coord.NO_COORD;
import game.Coord;
import game.Tile;
import haxe.ds.HashMap;

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
    final myUnits = new HashMap<Coord,Tile>();
    final oppUnits = new HashMap<Coord,Tile>();
    final myRecyclers = new HashMap<Coord,Tile>();
    final oppRecyclers = new HashMap<Coord,Tile>();
    final oppTiles = new HashMap<Coord,Tile>();
    final myTiles = new HashMap<Coord,Tile>();
    final neutralTiles = new HashMap<Coord,Tile>();

	final actions:Array<String> = [];
	
	var needsGlobalInputs = true;
	var turn = 0;
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
				tiles[index] =tile;
				if( tile.owner == ME ) {
					myTiles.set( coord, tile );
					if( tile.units > 0 ) myUnits.set( coord, tile );
					else if( tile.recycler ) myRecyclers.set( coord, tile );
				} else if( tile.owner == OPP ) {
					oppTiles.set( coord, tile );
					if( tile.units > 0 ) oppUnits.set( coord, tile );
					else if( tile.recycler ) oppRecyclers.set( coord, tile );
				} else {
					neutralTiles.set( coord, tile );
				}
			}
		}
		if( turn == 0 ) initMap();
	}
	
	function setGlobalInputs( inputLine:String ) {
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
	
	function initMap() {
		var myStartPosition = NO_COORD;
		var oppStartPosition = NO_COORD;
		for( coord => tile in myTiles ) if( tile.units == 0 ) myStartPosition = coord;
		for( coord => tile in oppTiles ) if( tile.units == 0 ) oppStartPosition = coord;
		final startDistance = myStartPosition.manhattanToCoord( oppStartPosition );
		final offset = startDistance % 2 == 0 ? 0 : 1;
		final border = [];
		for( tile in tiles ) {
			final myDistance = myStartPosition.manhattanTo( tile.x, tile.y );
			final oppDistance = oppStartPosition.manhattanTo( tile.x, tile.y );
			if( myDistance == oppDistance - offset ) border.push( tileCoord( tile ));
		}
		trace( 'startDistance $startDistance  myStartPosition $myStartPosition  opStartPosition $oppStartPosition\n$border' );
	}

	public function process() {
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
		final output = actions.length == 0 ? "WAIT" : actions.join( ";" );
		#if localGame
		// trace( '$turn $output' );
		#end
		
		turn++;
		return output;
	}

	function xyIndex( x:Int, y:Int ) return y * width + x;
	function tileCoord( tile:Tile ) return coords[xyIndex( tile.x, tile.y )];
}
