package ai.data;

import haxe.ds.GenericStack;
import xa3.math.Pos;

class NodePool {
	
	final pool = new GenericStack<Node>();
	public var length = 0;

	public function new() {	}

	public function get( startCellId:Int, cell:Cell, distance = 1, ?parent:Node ) {
		if( pool.isEmpty() ) return new Node( startCellId, cell, distance, parent );
		else {
			final node = pool.pop();
			length--;
			node.init( startCellId, cell, distance, parent );
			
			return node;
		}
	}

	public function add( node:Node ) {
		pool.add( node );
		length++;
	}

	public function addNodes( node:List<Node> ) {
		while( !node.isEmpty()) {
			pool.add( node.pop() );
			length++;
		}
	}
}