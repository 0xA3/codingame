package mcts.tree;

import CodinGame.printErr;
import mcts.montecarlo.State;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;

class Node {
	
	public static final NO_NODE = new Node( State.NO_STATE, [] );
	public static var nodeCount = 0;

	public final id:Int;
	public var state:State;
	public var parent:Node;
	public final children:Array<Node>;

	public var isInPool = false;

	public function new( state:State, children:Array<Node>, ?parent:Node ) {
		this.id = nodeCount;
		this.state = state;
		this.children = children;
		this.parent = parent == null ? Node.NO_NODE : parent;
		
		#if interp
		if( nodeCount == null ) nodeCount = 0;
		#end

		nodeCount++;
	}

	public function getRandomChildNode() {
		if( children.length == 0 ) throw "Error: child array is empty";
		
		final noOfPossibleMoves = children.length;
		final selectRandom = Std.int( Math.random() * noOfPossibleMoves );
		
		return children[selectRandom];
	}

	public function getChildWithMaxScore() {
		if( children.length == 0 ) throw "Error: child array is empty";
		
		// solution without sorting
		// var childWithMaxScore = children[0];
		// for( child in children ) if( child.state.visitCount > childWithMaxScore.state.visitCount ) childWithMaxScore = child;
		// return childWithMaxScore;

		// solution with sorting
		children.sort(( a, b ) -> b.state.visitCount - a.state.visitCount );
		return children[0];
	}

	public function toString() {
		return 'id: $id';
	}

}