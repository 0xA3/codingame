package mcts.tree;

import CodinGame.printErr;
import mcts.montecarlo.State;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;

class Node {
	
	public final state:State;
	public final parent:Node;
	public final children:Array<Node>;

	public function new( state:State, children:Array<Node>, ?parent:Node ) {
		this.state = state;
		this.children = children;
		this.parent = parent;
	}

	public static function create( board:IBoard ) {
		final state = State.create( board );
		final children = new Array<Node>();
		
		return new Node( state, children );
	}

	public static function fromState( state:State ) {
		final children = new Array<Node>();
		return new Node( state, children );
	}

	public static function copy( node:Node ) {
		final children = new Array<Node>();
		final state = State.copy( node.state );
		for( child in node.children ) children.push( Node.copy( child ));

		return new Node( state, children, node.parent );
	}

	public function getNodeOfMove( p:Position ) {
		for( child in children ) if( child.state.board.move == p ) return child;

		final node = Node.copy( this );

		printErr( '${node.state.board}' );
		printErr( 'position: $p' );


		node.state.board.performMove( state.playerNo, p );
		
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