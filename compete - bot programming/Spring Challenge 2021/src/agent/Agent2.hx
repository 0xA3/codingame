package agent;

import CodinGame.printErr;
import xa3.MTRandom;

using Lambda;

class Agent2 extends Agent {

	override function takeAction() {

		final myTrees = [for( index => tree in trees ) if( tree.owner.index == me.index ) index => tree ];
		final treesRichness = [for( index => tree in trees ) { richness: cells[index].richness, index: index, tree: tree }];

		treesRichness.sort(( a, b ) -> b.richness - a.richness );
		step++;
		
		// final treeOutput = [for( index => tree in myTrees ) 'tree:$index $tree'].join( ", " );
		// printErr( 'day:$day sun:${me.sun} score:${me.score}  [ $treeOutput ]  possibleActions $possibleActions' );
		// printErr( 'possibleActions $possibleActions' );
		
		final actionId = MTRandom.quickIntRand( possibleActions.length );
		return possibleActions[actionId];

	}
}