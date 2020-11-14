package mcts.montecarlo;

import mcts.tree.Node;

class UCT {
	
	public static function uctValue( totalVisit:Int, nodeWinScore:Float, nodeVisit:Int ):Float {
		if( nodeVisit == 0 ) return Integer.MAX_VALUE;
		return ( nodeWinScore / nodeVisit ) + 1.41 * Math.sqrt( Math.log( totalVisit ) / nodeVisit );
	}

	public static function findBestNodeWithUCT( node:Node ) {
		if( node.childArray.length == 0 ) throw "Error: childArray length is 0";
		final parentVisit = node.state.visitCount;
		node.childArray.sort(( a, b ) -> {
			final aUct = uctValue( parentVisit, a.state.winScore, a.state.visitCount );
			final bUct = uctValue( parentVisit, b.state.winScore, b.state.visitCount );
			if( aUct > bUct ) return -1;
			if( bUct > aUct ) return 1;
			return 0;
		});
		return node.childArray[0];
	}
}