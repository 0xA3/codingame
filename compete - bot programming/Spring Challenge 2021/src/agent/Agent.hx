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
	static var sunWeights = createSunWeights();
	
	final board:Board;
	// final cells:Array<Cell> = [];
	final trees:Map<Int, Tree> = [];
	final myTrees:Map<Int, Tree> = [];
	final oppTrees:Map<Int, Tree> = [];
	var day:Int;
	var nutrients:Int;
	var possibleActions:Array<String>;
	// var deltaIncome = 0.0;

	final growActions:Array<Int> = [];
	final completeActions:Array<Int> = [];
	final seedActions:Array<Array<Int>> = [];

	// var step = 0;

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
		final agent = new Agent6( new Player( 1 ), new Player( 0 ), new Board( cellsMap ) );
		

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
	}

	public inline function process(day:Int, nutrients:Int, myInputs:Array<String>, oppInputs:Array<String>, treesInputs:Array<Array<String>>, possibleActions:Array<String>):String {
		
		this.day = day;
		this.nutrients = nutrients;

		final sun = parseInt( myInputs[0] ); // your sun points
		me.sun = sun;
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

	function getAverageShadowOfIndex( index:Int, size:Int ) {
		return getAverageShadowOfCoord( board.coords[index], size );
	}

	function getAverageShadowOfCoord( coord:CubeCoord, size:Int ) {
		var sum = 0;
		for( orientation in 0...6 ) sum += getShadowOfCoord( coord, size, orientation );
		return sum / 6;
	}

	function getAverageFutureShadowOfIndex( index:Int, size:Int ) {
		return getAverageFutureShadowOfCoord( board.coords[index], size );
	}

	static function createSunWeights() {
		final totalWeights = [];
		var weightsSum = 0;
		for( i in 0...6 ) {
			final v = 6 - i;
			totalWeights[i] = v;
			weightsSum += v;
		};
		var sunWeights = totalWeights.map( v -> v / weightsSum );
		
		return sunWeights;
	}
	
	function getAverageWeightedShadowOfIndex( index:Int, size:Int ) {
		return getAverageWeightedShadowOfCoord( board.coords[index], size );
	}

	function getAverageWeightedShadowOfCoord( coord:CubeCoord, size:Int ) {
		final currentOri = day % 6;
		var sum = 0.0;
		for( i in 0...6 ) {
			final shadow = getShadowOfCoord( coord, size, ( currentOri + i ) % 6 );
			final weightedShadow = shadow * sunWeights[i];
			// trace( 'dir ${( currentOri + i ) % 6} cell ${board.cubeMap[coord].index} shadow $shadow weight ${sunWeights[i]}: $weightedShadow' );
			sum += weightedShadow;
		}
		return sum;
	}

	function getAverageFutureShadowOfCoord( coord:CubeCoord, size:Int ) {
		final currentOri = day % 6;
		final shadowValues = [];
		for( i in 0...6 ) {
			final orientation = ( currentOri + i ) % 6;
			shadowValues[orientation] = getShadowOfCoord( coord, size, orientation );
		}
		final sum = 0.0;
		for( i in day + 1...Config.MAX_ROUNDS ) sum += shadowValues[i % 6];
		return sum / ( Config.MAX_ROUNDS - (day + 1));
	}

	function getShadowOfCoord( coord:CubeCoord, size:Int, orientation:Int ) {
		for( i in 1...4 ) {
			final neighbor = coord.neighbor(( orientation + 3 ) % 6, i );
			if( board.map.exists( neighbor.s )) {
				final index = board.map[neighbor.s].index;
				if( trees.exists( index )) {
					final tree = trees[index];
					return tree.size >= size && tree.size >= i ? 1 : 0;
				}
			}
		}
		
		return 0;
	}

	function parsePossibleActions( possibleActions:Array<String> ) {
		growActions.splice( 0, growActions.length );
		completeActions.splice( 0, completeActions.length );
		seedActions.splice( 0, seedActions.length );

		for( action in possibleActions ) {
			if( action != "WAIT" ) {
				final parts = action.split(" ");
				final command = parts[0];
				switch command {
				case "GROW": growActions.push( parseInt( parts[1] ));
				case "COMPLETE": completeActions.push( parseInt( parts[1] ));
				case "SEED": seedActions.push( [parseInt( parts[1] ), parseInt( parts[2] )] );
				default: throw 'Error unknown command $action';
				}
			}
		}
	}

}
