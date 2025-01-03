package ai.data;

import haxe.ds.GenericStack;
import xa3.math.Pos;

class NodePool {
	
	final pool = new GenericStack<Node>();
	public var length = 0;

	public function new() {	}

	public function get( rootId:Int, startCellId:Int, cell:Cell, distance = 1, ?parent:Node ) {
		if( pool.isEmpty() ) return new Node( rootId, startCellId, cell, distance, parent );
		else {
			final node = pool.pop();
			length--;
			node.init( rootId, startCellId, cell, distance, parent );
			
			return node;
		}
	}

	public function add( node:Node ) {
		pool.add( node );
		length++;
	}

	public function addNodeList( node:List<Node> ) {
		while( !node.isEmpty()) {
			pool.add( node.pop() );
			length++;
		}
	}

	public function addNodesHierarchy( nodes:Array<Node> ) {
		for( i in -nodes.length + 1...1 ) {
			addNodeHerarchy( nodes[i] );
		}
		nodes.splice( 0, nodes.length );
	}

	public function addNodeHerarchy( node:Node ) {
		while( node != null ) {
			pool.add( node );
			length++;
			node = node.parent;
		}
	}
}