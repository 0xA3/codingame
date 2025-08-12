package mcts.tree;

import CodinGame.printErr;
import haxe.ds.GenericStack;
import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;

class NodePool {
	
	final statePool:StatePool;

	final pool = new GenericStack<Node>();
	public var length = 0;

	public function new( statePool:StatePool ) {
		this.statePool = statePool;
	}

	public function get( state:State, ?parent:Node ) {
		if( pool.isEmpty() ) {
			final node = Node.create( state, parent );
			// printErr( 'create Node ${node.id}' );
			return node;
		
		} else {
			final node = pool.pop();
			if( parent != null ) node.parent = parent;
			// printErr( 'reuse Node ${node.id}' );
			node.isInPool = false;
			node.state = state;

			length--;
			
			return node;
		}
	}

	public function recycle( node:Node ) {
		if( node.isInPool ) {
			printErr( 'Node ${node.id} is already in pool.' );
			return;
		}

		statePool.recycle( node.state );
		node.state = State.NO_STATE;

		node.parent.children.remove( node );

		if( node.children.length > 0 ) for( child in node.children ) child.parent = Node.NO_NODE;
		node.children.splice( 0, node.children.length );
		
		// printErr( 'return Node ${node.id} to pool' );
		node.parent = Node.NO_NODE;
		pool.add( node );
		node.isInPool = true;
		
		length++;
	}

	public function recycleBranch( node:Node, depth = 0 ) {
		if( node.isInPool ) {
			printErr( 'Node ${node.id} is already in pool.' );
			return;
		}
		
		statePool.recycle( node.state );
		node.state = State.NO_STATE;

		if( depth == 0 ) node.parent.children.remove( node );

		while( node.children.length > 0 ) {
			node.children[0].parent = Node.NO_NODE;
			recycleBranch( node.children.shift(), depth + 1 );
		}
		
		// printErr( 'return Node ${node.id} to pool' );
		node.parent = Node.NO_NODE;
		pool.add( node );
		node.isInPool = true;
		
		length++;
	}
}