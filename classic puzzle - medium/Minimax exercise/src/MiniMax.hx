
class MiniMax {
	
	static inline var MAX = 100000;
	static inline var MIN = -100000;
	
	public var visitedNodesQuantity = 0;

	final depth:Int;
	final branchingFactor:Int;
	final leafs:Array<Int>;

	public function new( depth:Int, branchingFactor:Int, leafs:Array<Int> ) {
		
		this.depth = depth;
		this.branchingFactor = branchingFactor;
		this.leafs = leafs;
	}

	public function evaluate( alpha = MIN, beta = MAX, nodeIndex = 0, isMax = true, currentDepth = 0 ) {

		visitedNodesQuantity++;
		// base case : depth reached
		if( currentDepth == depth ) return leafs[nodeIndex];

		if( isMax ) {

			var best = MIN;

			// Recur for left and right children
			for( i in 0...branchingFactor ) {
				final val = evaluate( alpha, beta, nodeIndex * branchingFactor + i, false, currentDepth + 1 );
				best = Std.int( Math.max( best, val ));
				alpha = Std.int( Math.max( alpha, best ));
				
				// Alpha Beta Pruning
				if( beta <= alpha ) break;
			}

			return best;

		} else {

			var best = MAX;
			// Recur for left and right children
			for( i in 0...branchingFactor ) {

				final val = evaluate( alpha, beta, nodeIndex * branchingFactor + i, true, currentDepth + 1);
				best = Std.int( Math.min( best, val ));
				beta = Std.int( Math.min( beta, best ));
				
				// Alpha Beta Pruning
				if( beta <= alpha ) break;

			}

			return best;

		}
	}
}