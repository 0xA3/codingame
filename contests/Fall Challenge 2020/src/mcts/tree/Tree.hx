package mcts.tree;

class Tree {
	
	public var rootNode:Node;

	public function new( rootNode:Node ) {
		this.rootNode = rootNode;
	}

	public function addChild( parent:Node, child:Node ) {
		parent.childArray.push( child );
	}
}