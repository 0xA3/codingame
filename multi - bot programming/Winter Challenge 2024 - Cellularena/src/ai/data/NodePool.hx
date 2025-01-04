package ai.data;

import algorithm.MinPriorityQueue;
import haxe.ds.GenericStack;
import xa3.math.Pos;

class NodePool {
	
	final pool = new GenericStack<Node>();
	public var length = 0;

	public function new() {	}

	public function get(
		rootId:Int,
		startCellId:Int,
		cell:Cell,
		tCell:TCell,
		direction:TDir,
		a:Int,
		b:Int,
		c:Int,
		d:Int,
		distance = 0,
		?parent:Node
	) {
		if( pool.isEmpty() ) {
			final node = new Node();
			node.init( rootId, startCellId, cell, tCell, direction, a, b, c, d, distance, parent );
			
			return return node;
		
		} else {
			final node = pool.pop();
			length--;
			node.init( rootId, startCellId, cell, tCell, direction, a, b, c, d, distance, parent );
			
			return node;
		}
	}

	public function add( node:Node ) {
		pool.add( node );
		length++;
	}

	public function addNodeList( nodes:List<Node> ) {
		while( !nodes.isEmpty()) {
			pool.add( nodes.pop() );
			length++;
		}
	}

	public function addNodeQueue( queue:MinPriorityQueue<Node> ) {
		while( !queue.isEmpty()) {
			pool.add( queue.delMin() );
			length++;
		}
	}

	public function addNodesHierarchy( nodes:Array<Node> ) {
		for( i in -nodes.length + 1...1 ) addNodeHerarchy( nodes[i] );
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