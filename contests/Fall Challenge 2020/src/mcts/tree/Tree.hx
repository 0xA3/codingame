package mcts.tree;

class Tree {
	
	public var rootNode:Node;

	public function new( rootNode:Node ) {
		this.rootNode = rootNode;
	}

	public function addChild( parent:Node, child:Node ) {
		parent.childArray.push( child );
	}

	public function display( maxDepth = 100 ) {
		return rootNode.display( rootNode.state.board.totalMoves, maxDepth );
	}

}