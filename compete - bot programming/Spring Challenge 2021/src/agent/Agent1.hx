package agent;

import CodinGame.printErr;
import Std.parseInt;
import game.Tree;

using Lambda;

class Agent1 extends Agent {

	override function takeAction() {

		final myTrees = [for( index => tree in trees ) if( tree.owner.index == me.index ) index => tree ];
		final treesRichness = [for( index => tree in trees ) { richness: cells[index].richness, index: index, tree: tree }];

		treesRichness.sort(( a, b ) -> b.richness - a.richness );
		step++;
		
		// final treeOutput = [for( index => tree in myTrees ) 'tree:$index $tree'].join( ", " );
		// printErr( 'day:$day sun:${me.sun} score:${me.score}  [ $treeOutput ]  possibleActions $possibleActions' );
		
		// GROW cellIdx | SEED sourceIdx targetIdx | COMPLETE cellIdx | WAIT <message>
		if( treesRichness.length > 0 ) {
			final p1Tree = treesRichness[0].tree;
			if( p1Tree.size == 3 ) {
				return 'COMPLETE ${treesRichness[0].index}';
			} else {
				return 'GROW ${treesRichness[0].index}';
			}
		} else {
			return 'WAIT';
		}
		
	}
}