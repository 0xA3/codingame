package mcts.tree;

import CodinGame.printErr;
import haxe.ds.GenericStack;
import mcts.tictactoe.IBoard;

class NodePool {
	
	final pool = new GenericStack<Node>();
	public var length = 0;

	public function new() {	}

	public function get( player:Int, board:IBoard ) {
		if( pool.isEmpty() ) {
			final node = Node.create( player, board );
			return node;
		
		} else {
			final node = pool.pop();
			node.isInPool = false;

			length--;
			
			return node;
		}
	}

	public function getCopy( node:Node ) {
		return node.copy();
	}

	public function add( node:Node ) {
		if( node.isInPool ) {
			printErr( 'Node is already in pool' );
			return;
		}
		node.isInPool = true;
		pool.add( node );
		length++;
	}

	public function addBranch( node:Node ) {
		var tempNode = node;
		tempNode.parent = Node.NO_NODE;
		add( tempNode );
		while( tempNode.children.length > 0 ) {
			addBranch( tempNode.children[0] );
			add( tempNode.children.shift() );
		}
	}

	public function addNodeHerarchy( node:Node ) {
		while( node != null ) {
			if( !node.isInPool ) {
				node.isInPool = true;
				pool.add( node );
				length++;
			} else {
				printErr( 'Node is already in pool' );
			}
			node = node.parent;
		}
	}
}