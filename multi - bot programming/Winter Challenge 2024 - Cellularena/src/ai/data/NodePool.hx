package ai.data;

import CodinGame.printErr;
import algorithm.MinPriorityQueue;
import haxe.ds.GenericStack;

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
			node.isInPool = false;

			length--;
			node.init( rootId, startCellId, cell, tCell, direction, a, b, c, d, distance, parent );
			
			return node;
		}
	}

	public function add( node:Node ) {
		if( node.isInPool ) {
			printErr( 'Node ${node.cell.pos} already in pool' );
			return;
		}
		node.isInPool = true;
		pool.add( node );
		length++;
	}

	public function addNodeList( nodes:List<Node> ) {
		while( !nodes.isEmpty()) {
			final node = nodes.pop();
			if( !node.isInPool ) {
				node.isInPool = true;
				pool.add( node );
				length++;
			} else {
				printErr( 'Node ${node.cell.pos} already in pool' );
			}
		}
	}

	public function addNodeQueue( queue:MinPriorityQueue<Node> ) {
		while( !queue.isEmpty()) {
			final node = queue.delMin();
			if( !node.isInPool ) {
				node.isInPool = true;
				pool.add( queue.delMin() );
				length++;
			} else {
				printErr( 'Node ${node.cell.pos} already in pool' );
			}
		}
	}

	public function addNodeQueues( queues:MinPriorityQueue<Node> ) {
		while( !queues.isEmpty()) {
			addNodeHerarchy( queues.delMin() );
		}
	}

	public function addNodesHierarchy( nodes:Array<Node> ) {
		for( i in -nodes.length + 1...1 ) addNodeHerarchy( nodes[i] );
		nodes.splice( 0, nodes.length );
	}

	public function addNodeHerarchy( node:Node ) {
		while( node != null ) {
			if( !node.isInPool ) {
				node.isInPool = true;
				pool.add( node );
				length++;
			} else {
				printErr( 'Node ${node.cell.pos} already in pool' );
			}
			node = node.parent;
		}
	}
}