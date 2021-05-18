package agent;

import CodinGame.printErr;

using Lambda;

class Agent1 extends Agent {

	override function takeAction() {

		myTrees.clear();
		for( index => tree in trees ) if( tree.owner.index == me.index ) myTrees.set( index, tree );
		final treesRichness = [for( index => tree in myTrees ) { richness: cells[index].richness, index: index, tree: tree }];

		treesRichness.sort(( a, b ) -> b.richness - a.richness );
		step++;
		
		// final treeOutput = [for( index => tree in myTrees ) 'tree:$index $tree'].join( ", " );
		final treeOutput = [for( index => tree in myTrees ) 'tree:$index'].join( ", " );
		// printErr( 'day:$day sun:${me.sun} score:${me.score}  [ $treeOutput ]  possibleActions $possibleActions' );
		// printErr( 'day:$day sun:${me.sun} score:${me.score}  [ $treeOutput ]' );
		
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