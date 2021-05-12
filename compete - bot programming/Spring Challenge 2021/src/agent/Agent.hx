package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;
import game.Board;
import game.Cell;
import game.Config;
import game.Constants;
import game.CubeCoord;
import game.Player;
import game.Tree;
import haxe.Timer;
import xa3.MTRandom;

using Lambda;

class Agent {
	
	public final me:Player;
	public final opp:Player;
	
	final board:Board;
	final cells:Array<Cell> = [];
	final trees:Map<Int, Tree> = [];
	final myTrees:Map<Int, Tree> = [];
	final oppTrees:Map<Int, Tree> = [];
	var day:Int;
	var nutrients:Int;
	var possibleActions:Array<String>;
	
	var step = 0;

	/*
		Startup for submitting the agent to CodinGame
	*/
	static function main() {
		
		MTRandom.initializeRandGenerator( 1234 );

		final cubeCoords = generateCubeCoords( Config.MAP_RING_COUNT );
		final cellsMap:Map<CubeCoord, Cell> = [];
		
		final numberOfCells = parseInt( readline() ); // 37
		for( i in 0...numberOfCells ) {
			final inputs = readline().split( ' ' );
			final index = parseInt( inputs[0] ); // 0 is the center cell, the next cells spiral outwards
			final richness = parseInt( inputs[1] ); // 0 if the cell is unusable, 1-3 for usable cells
			final cell = new Cell( index, richness );
			cellsMap.set( cubeCoords[i], cell );
		}
		
		//
		// Add Agent
		//
		final agent = new Agent3( new Player( 1 ), new Player( 0 ), new Board( cellsMap ) );
		

		// game loop
		while ( true ) {
			final day = parseInt( readline() ); // the game lasts 24 days: 0-23
			final nutrients = parseInt( readline() ); // the base score you gain from the next COMPLETE action
			final myInputs = readline().split( ' ' );
			final oppInputs = readline().split( ' ' );
			
			final numberOfTrees = parseInt( readline() ); // the current amount of trees
			final treesInputs = [for( i in 0...numberOfTrees ) readline().split( ' ' )];
			
			final numberOfPossibleActions = parseInt( readline() ); // all legal actions
			final possibleActions = [for( i in 0...numberOfPossibleActions ) readline()]; // try printing something from here to start with

			final outputs = agent.process( day, nutrients, myInputs, oppInputs, treesInputs, possibleActions );
			print( outputs );
		}

	}
	
	/*
		Startup for local referee
	*/
	public function new( me:Player, opp:Player, board:Board ) {
		MTRandom.initializeRandGenerator( 0 );
		
		this.me = me;
		this.opp = opp;
		this.board = board;
		this.cells = [for( cell in board.map ) cell];
		cells.sort(( a, b ) -> a.index - b.index );
	}

	public inline function process(day:Int, nutrients:Int, myInputs:Array<String>, oppInputs:Array<String>, treesInputs:Array<Array<String>>, possibleActions:Array<String>):String {
		
		this.day = day;
		this.nutrients = nutrients;

		me.sun = parseInt( myInputs[0] ); // your sun points
		me.score = parseInt( myInputs[1] ); // your current score
	
		opp.sun = parseInt( oppInputs[0] ); // opp's sun points
		opp.score = parseInt( oppInputs[1] ); // opp's score
		opp.isWaiting = oppInputs[2] != '0'; // whether your opp is asleep until the next day

		trees.clear();
		for( inputs in treesInputs ) {
			final cellIndex = parseInt( inputs[0] ); // location of this tree
			final size = parseInt( inputs[1] ); // size of this tree: 0-3
			final isMine = inputs[2] == '1'; // 1 if this is your tree
			final isDormant = inputs[3] == '1'; // 1 if this tree is dormant
			final tree = new Tree( isMine ? me : opp );
			tree.size = size;
			tree.isDormant = isDormant;
			
			trees.set( cellIndex, tree );
		}
		this.possibleActions = possibleActions;
		
		return takeAction();
	}
	
	public function takeAction() {
		return 'WAIT';
	}

	static inline function generateCubeCoords( ringCount:Int ) {
		final coords = [];
		
		final center = new CubeCoord( 0, 0, 0 );
		coords.push( center );

		var coord = center.neighbor( 0 );
		
		for( distance in 1...Config.MAP_RING_COUNT + 1 ) {
			for( orientation in 0...6 ) {
				for( _ in 0...distance ) {
					coords.push( coord );
					coord = coord.neighbor(( orientation + 2 ) % 6 );
				}
			}
			coord = coord.neighbor( 0 );
		}
		// trace( "\n" + [for( i in 0...coords.length ) '$i : ${coords[i]}'].join( "\n" ));
		return coords;
	}
	
	function getGrowthCost( targetTree:Tree ) {
		final targetSize = targetTree.size + 1;
		return targetSize > Constants.TREE_TALL ? Constants.LIFECYCLE_END_COST : getCostFor( targetSize, targetTree.owner );
	}

	function getSeedCost( player:Player ) return getCostFor( 0, player );

	function getCostFor( size:Int, owner:Player ) {
		final baseCost = Constants.TREE_BASE_COST[size];
		final sameTreeCount = [for( tree in trees ) tree].filter( t -> t.size == size && t.owner == owner ).length;
		
		return baseCost + sameTreeCount;
	}

}
