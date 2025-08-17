package mcts.tree;

import CodinGame.printErr;
import haxe.ds.GenericStack;
import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;

class NodePool {
	
	final statePool:StatePool;

	public final pool = new GenericStack<Node>();
	public var length = 0;

	public function new( statePool:StatePool ) {
		this.statePool = statePool;
	}

	public function get( state:State, ?parent:Node ) {
		if( pool.isEmpty() ) {
			final node = new Node( state, [], parent );
			// printErr( 'create Node ${node.id} with state ${state.id}' );
			if( node.id != state.id ) throw 'Error: Node id ${node.id} != state id ${state.id}';
			return node;
		
		} else {
			final node = pool.pop();
			if( parent != null ) node.parent = parent;
			// printErr( 'use Node ${node.id} with state ${state.id}  lengths $length | ${statePool.length}' );
			node.isInPool = false;
			node.state = state;
			if( node.id != state.id ) {
				final poolNodes = [for( node in pool ) node.id].join( ', ' );
				final poolStates = [for( state in statePool.pool ) state.id].join( ', ' );
				printErr( 'poolNodes: $poolNodes\npoolStates: $poolStates' );
				throw 'Error: Node id ${node.id} != state id ${state.id}';
			}
			
			length--;
			
			return node;
		}
	}

	public function recycle( node:Node ) {
		// printErr( 'recycle Node Node ${node.id} | state ${node.state.id}  lengths $length | ${statePool.length}' );
		if( node.isInPool ) {
			printErr( 'Error: Node ${node.id} is already in pool.' );
			throw 'Error: Node ${node.id} is already in pool.';
		}
		
		statePool.recycle( node.state );
		node.state = State.NO_STATE;

		node.parent.children.remove( node );

		if( node.children.length > 0 ) for( child in node.children ) child.parent = Node.NO_NODE;
		node.children.splice( 0, node.children.length );
		
		node.parent = Node.NO_NODE;
		pool.add( node );
		node.isInPool = true;
		
		length++;
	}

	public function recycleBranch( node:Node, depth = 0 ) {
		// printErr( 'recycleBranch Node ${node.id} | state ${node.state.id}  lengths $length | ${statePool.length}' );
		if( node.isInPool ) {
			printErr( 'Error: Node ${node.id} is already in pool.' );
			throw 'Error: Node ${node.id} is already in pool.';
		}
		
		statePool.recycle( node.state );
		node.state = State.NO_STATE;

		if( depth == 0 ) node.parent.children.remove( node );
		pool.add( node );

		for( child in node.children ) {
			child.parent = Node.NO_NODE;
			recycleBranch( child, depth + 1 );
		}
		node.children.splice( 0, node.children.length );
		
		node.parent = Node.NO_NODE;
		node.isInPool = true;
		
		length++;
	}
}