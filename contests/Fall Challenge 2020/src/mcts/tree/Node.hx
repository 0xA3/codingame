package mcts.tree;

import mcts.montecarlo.State;

class Node {
	
	public final state:State;
	public final parent:Node;
	public final childArray:Array<Node>;

	public function new( state:State, childArray:Array<Node>, ?parent:Node ) {
		this.state = state;
		this.childArray = childArray;
		this.parent = parent;
	}

	public static function createEmpty() {
		final state = State.createEmpty();
		final childArray = new Array<Node>();
		
		return new Node( state, childArray );
	}

	public static function fromState( state:State ) {
		final childArray = new Array<Node>();
		return new Node( state, childArray );
	}

	public function getRandomChildNode() {
		if( childArray.length == 0 ) throw "Error: childArray is empty";
		
		final noOfPossibleMoves = childArray.length;
		final selectRandom = Std.int( Math.random() * noOfPossibleMoves );
		
		return childArray[selectRandom];
	}

	public function getChildWithMaxScore() {
		if( childArray.length == 0 ) throw "Error: childArray is empty";
		childArray.sort(( a, b ) -> b.state.visitCount - a.state.visitCount );
		return childArray[0];
	}

	public function clone() {
		return new Node( state.clone(), childArray.map( child -> child.clone()), parent );
	}

}