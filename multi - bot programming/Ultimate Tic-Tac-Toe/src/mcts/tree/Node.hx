package mcts.tree;

import CodinGame.printErr;
import mcts.montecarlo.State;
import mcts.tictactoe.Position;

class Node {
	
	public final state:State;
	public final parent:Node;
	public final childArray:Array<Node>;

	public function new( state:State, childArray:Array<Node>, ?parent:Node ) {
		this.state = state;
		this.childArray = childArray;
		this.parent = parent;
	}

	public static function create( boardSize:Int ) {
		final state = State.create( boardSize );
		final childArray = new Array<Node>();
		
		return new Node( state, childArray );
	}

	public static function fromState( state:State ) {
		final childArray = new Array<Node>();
		return new Node( state, childArray );
	}

	public static function copy( node:Node ) {
		final childArray = new Array<Node>();
		final state = State.fromState( node.state );
		for( child in node.childArray ) childArray.push( Node.copy( child ));

		return new Node( state, childArray, node.parent );
	}

	public function getNodeOfMove( p:Position ) {
		for( child in childArray ) if( child.state.board.move == p ) return child;

		final node = Node.copy( this );
		node.state.board.performMove( state.playerNo, p );
		
		return node;
	}

	public function getRandomChildNode() {
		if( childArray.length == 0 ) throw "Error: childArray is empty";
		
		final noOfPossibleMoves = childArray.length;
		final selectRandom = Std.int( Math.random() * noOfPossibleMoves );
		
		return childArray[selectRandom];
	}

	public function getChildWithMaxScore() {
		if( childArray.length == 0 ) throw "Error: childArray is empty";
		
		// solution without sorting
		// var childWithMaxScore = childArray[0];
		// for( child in childArray ) if( child.state.visitCount > childWithMaxScore.state.visitCount ) childWithMaxScore = child;
		// return childWithMaxScore;

		// solution with sorting
		childArray.sort(( a, b ) -> b.state.visitCount - a.state.visitCount );
		return childArray[0];
	}

	public function toString() {
		return 'state: $state';
	}

}