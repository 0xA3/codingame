package ai.data;

import haxe.ds.GenericStack;

class NodePool {
	
	final nodes = new GenericStack<Node>();

	public function new() { }

	public function get() {
		if( nodes.isEmpty() ) return new Node();

		return nodes.pop();
	}

	public function dump( node:Node ) {
		node.reset();
		nodes.add( node );
	}
}
