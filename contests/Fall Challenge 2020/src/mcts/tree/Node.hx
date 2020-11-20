package mcts.tree;

import mcts.montecarlo.State;

using Lambda;

class Node {
	
	public final state:State;
	public final parent:Node;
	public final childArray:Array<Node>;

	public var nodeValue:Float = 0;

	public function new( state:State, childArray:Array<Node>, ?parent:Node, value = 0.0 ) {
		this.state = state;
		this.childArray = childArray;
		this.parent = parent;
	}

	public static function createEmpty( name:String ) {
		final state = State.createEmpty( name );
		final childArray = new Array<Node>();
		
		return new Node( state, childArray );
	}

	public static function fromState( state:State ) {
		final childArray = new Array<Node>();
		final nodeValue = state.board.getNodeValue();
		return new Node( state, childArray, nodeValue );
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

	public function toString() {
		return 'state: $state, childArray: $childArray';
	}

	public function displayNode() {
		final action = state.board.action == null ? "none" : '${state.board.action.actionType} ${state.board.action.actionId}';
		return 'level: ${state.board.totalMoves} winScore: ${state.winScore} action: $action';
	}

	public function display( levelOffset:Int, maxDepth:Int ) {
		final children = maxDepth > 0 ? childArray.mapi((i, node ) -> node.display( levelOffset, maxDepth - 1 )).join("") : "";
		final level = state.board.totalMoves - levelOffset;
		final spaces = [for(i in 0...level) "  "].join("");
		final action = state.board.action == null ? "none" : '${state.board.action.actionType} ${state.board.action.actionId}';
		// return '${spaces}level: $level visitCount: ${state.visitCount} winScore: ${state.winScore} action: $action\n$children';
		return '${spaces}level: $level nodeValue: $nodeValue action: $action\n$children';
	}
}