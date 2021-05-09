package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import game.Board;
import game.Cell;
import game.Config;
import game.CubeCoord;
import game.Player;
import game.Tree;
import haxe.Timer;

using Lambda;

class Agent {
	static var me:Player;
	static var opp:Player;
	
	static var board:Board;
	static var cells:Array<Cell> = [];
	static var trees:Map<Int, Tree> = [];

	static var step = 0;

	static function main() {
		
		me = new Player( 0 );
		opp = new Player( 1 );
		final cubeCoords = generateCubeCoords( Config.MAP_RING_COUNT );
		
		final numberOfCells = parseInt( readline() ); // 37
		
		final cellsMap:Map<CubeCoord, Cell> = [];
		for( i in 0...numberOfCells ) {
			final inputs = readline().split( ' ' );
			final index = parseInt( inputs[0] ); // 0 is the center cell, the next cells spiral outwards
			final richness = parseInt( inputs[1] ); // 0 if the cell is unusable, 1-3 for usable cells
			final cell = new Cell( index, richness );
			cellsMap.set( cubeCoords[i], cell );
			cells.push( cell );
		}
		
		board = new Board( cellsMap );
		
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
			// printErr( possibleActions );
			// printErr( 'step $step day $day nutrients $nutrients' );

			process( day, nutrients, myInputs, oppInputs, treesInputs, possibleActions );
		}

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

	static inline function process( day:Int, nutrients:Int, myInputs:Array<String>, oppInputs:Array<String>, treesInputs:Array<Array<String>>, possibleAction:Array<String> ) {

		me.sun = parseInt( myInputs[0] ); // your sun points
		me.score = parseInt( myInputs[1] ); // your current score
	
		opp.sun = parseInt( oppInputs[0] ); // opp's sun points
		opp.score = parseInt( oppInputs[1] ); // opp's score
		opp.isWaiting = oppInputs[2] != '0'; // whether your opp is asleep until the next day

		trees.clear();
		for( inputs in treesInputs ) {
			final cellIndex = parseInt( inputs[0] ); // location of this tree
			final size = parseInt( inputs[1] ); // size of this tree: 0-3
			final isMine = inputs[2] != '0'; // 1 if this is your tree
			final isDormant = inputs[3] != '0'; // 1 if this tree is dormant
			final tree = new Tree( isMine ? me : opp, cellIndex );
			tree.size = size;
			tree.isDormant = isDormant;
			
			trees.set( cellIndex, tree );
		}

		final myTrees = trees.filter( tree -> tree.owner.index == 0 );
		final treesRichness = myTrees.map( tree -> { richness: cells[tree.fatherIndex].richness, tree: tree });

		treesRichness.sort(( a, b ) -> b.richness - a.richness );
		
		// GROW cellIdx | SEED sourceIdx targetIdx | COMPLETE cellIdx | WAIT <message>
		if( treesRichness.length > 0 ) {
			final p1Tree = treesRichness[0].tree;
			if( p1Tree.size == 3 ) {
				print( 'COMPLETE ${p1Tree.fatherIndex}' );
			} else {
				print( 'GROW ${p1Tree.fatherIndex}' );
			}
		} else {
			print( 'WAIT' );
		}

		step++;
		
	}

}
