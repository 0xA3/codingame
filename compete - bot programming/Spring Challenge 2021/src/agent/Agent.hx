package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import agent.data.Cell;
import agent.data.Tree;
import haxe.Timer;

using Lambda;

class Agent {
	
	static function main() {
		
		final numberOfCells = parseInt( readline() ); // 37
		final cells:Array<Cell> = [for( i in 0...numberOfCells ) {
			final inputs = readline().split( ' ' );
			final index = parseInt( inputs[0] ); // 0 is the center cell, the next cells spiral outwards
			final richness = parseInt( inputs[1] ); // 0 if the cell is unusable, 1-3 for usable cells
			final neigh0 = parseInt( inputs[2] ); // the index of the neighbouring cell for each direction
			final neigh1 = parseInt( inputs[3] );
			final neigh2 = parseInt( inputs[4] );
			final neigh3 = parseInt( inputs[5] );
			final neigh4 = parseInt( inputs[6] );
			final neigh5 = parseInt( inputs[7] );

			{ index: index, richness: richness, neighs: [ neigh0, neigh1, neigh2, neigh3, neigh4, neigh5] };
			// printErr( 'index $index' );
		}];
		
		var step = 0;
		// game loop
		while ( true ) {
			final day = parseInt( readline() ); // the game lasts 24 days: 0-23
			final nutrients = parseInt( readline() ); // the base score you gain from the next COMPLETE action
			final inputs = readline().split( ' ' );
			final sun = parseInt( inputs[0] ); // your sun points
			final score = parseInt( inputs[1] ); // your current score
			final inputs = readline().split( ' ' );
			final oppSun = parseInt( inputs[0] ); // opponent's sun points
			final oppScore = parseInt( inputs[1] ); // opponent's score
			final oppIsWaiting = inputs[2] != '0'; // whether your opponent is asleep until the next day
			final numberOfTrees = parseInt( readline() ); // the current amount of trees
			final trees:Array<Tree> = [for( i in 0...numberOfTrees ) {
				final inputs = readline().split( ' ' );
				final cellIndex = parseInt( inputs[0] ); // location of this tree
				final size = parseInt( inputs[1] ); // size of this tree: 0-3
				final isMine = inputs[2] != '0'; // 1 if this is your tree
				final isDormant = inputs[3] != '0'; // 1 if this tree is dormant

				{ cellIndex: cellIndex, size: size, isMine: isMine, isDormant: isDormant };
			}];
			final numberOfPossibleActions = parseInt( readline() ); // all legal actions
			final possibleActions = [for( i in 0...numberOfPossibleActions ) readline()]; // try printing something from here to start with
			printErr(  possibleActions );
			// printErr( 'step $step day $day nutrients $nutrients' );

			final myTrees = trees.filter( tree -> tree.isMine );
			final treesRichness = myTrees.map( tree -> { richness: cells[tree.cellIndex].richness, tree: tree });

			treesRichness.sort(( a, b ) -> b.richness - a.richness );
			
			// GROW cellIdx | SEED sourceIdx targetIdx | COMPLETE cellIdx | WAIT <message>
			if( treesRichness.length > 0 ) {
				final p1Tree = treesRichness[0].tree;
				if( p1Tree.size == 3 ) {
					print( 'COMPLETE ${p1Tree.cellIndex}' );
				} else {
					print( 'GROW ${p1Tree.cellIndex}' );
				}
			} else {
				print( 'WAIT' );
			}

			step++;
			
		}

	}

}
