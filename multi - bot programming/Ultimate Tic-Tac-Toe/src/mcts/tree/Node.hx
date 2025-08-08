package mcts.tree;

import CodinGame.printErr;
import mcts.montecarlo.State;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;

class Node {
	
	public final state:State;
	public final parent:Node;
	public final children:Array<Node>;

	public static var nodeCount = 0;

	public function new( state:State, children:Array<Node>, ?parent:Node ) {
		this.state = state;
		this.children = children;
		this.parent = parent;
		
		nodeCount++;
	}

	public static function create( player:Int, board:IBoard ) {
		final state = State.create( player, board );
		final children = [];
		
		return new Node( state, children );
	}

	public static function fromState( state:State ) {
		final children = new Array<Node>();
		return new Node( state, children );
	}

	public function copy() {
		final children = [];
		for( child in children ) children.push( child.copy() );

		return new Node( state.copy(), children, parent );
	}

	public function getNodeOfMove( p:Position ) {
		for( child in children ) if( child.state.board.move == p ) return child;

		final node = this.copy();
		// printErr( '${node.state.board}' );
		// printErr( 'position: $p' );

		node.state.board.performMove( state.player, p );
		
		return node;
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
		return 'state: $state';
	}

}