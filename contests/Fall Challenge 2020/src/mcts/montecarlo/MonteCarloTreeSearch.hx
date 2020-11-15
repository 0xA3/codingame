package mcts.montecarlo;

import CodinGame.printErr;
import haxe.Timer;
import game.Board;
import mcts.tree.Node;
import mcts.tree.Tree;


class MonteCarloTreeSearch {
	
	public static inline var WIN_SCORE = 10;
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.9;
	
	final tree:Tree;
	
	public var level = 3;
	public var opponent:Int;

	public function new( tree:Tree ) {
		this.tree = tree;
	}

	public function findNextMove( playerNo:Int ) {
		
		final start = Timer.stamp();
		final end = start + RESPONSE_TIME;

		var playouts = 0;
		while( Timer.stamp() < end ) {
			// Phase 1 - Selection
			final promisingNode = selectPromisingNode( tree.rootNode );
			// Phase 2 - Expansion
			if( promisingNode.state.board.checkStatus() == Board.IN_PROGRESS ) expandNode( promisingNode );
			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.childArray.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();

			final playoutResult = simulateRandomPlayout( nodeToExplore );
			playouts++;
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
		}
		
		final winnerNode = tree.rootNode.getChildWithMaxScore();
		tree.rootNode = winnerNode;
		
		return winnerNode.state;
	}

	function selectPromisingNode( rootNode:Node ) {
		var node = rootNode;
		while( node.childArray.length != 0 ) node = UCT.findBestNodeWithUCT( node );
		return node;
	}

	function expandNode( node:Node ) {
		final possibleStates = node.state.getAllPossibleStates();
		for( state in possibleStates ) {
			final newNode = new Node( state, [], node );
			newNode.state.playerNo = node.state.getOpponent();
			node.childArray.push( newNode );
		}
	}

	function backPropagation( nodeToExplore:Node, playerNo:Int ) {
		var tempNode = nodeToExplore;
		while( tempNode != null ) {
			tempNode.state.incrementVisit();
			if( tempNode.state.playerNo == playerNo ) tempNode.state.addScore( WIN_SCORE );
			tempNode = tempNode.parent;
		}
	}

	function simulateRandomPlayout( node:Node ) {
		final tempNode = Node.fromNode( node );
		final tempState = tempNode.state;
		var boardStatus = tempState.board.checkStatus();

		if( boardStatus == opponent ) {
			tempNode.parent.state.winScore = Integer.MIN_VALUE;
			return boardStatus;
		}

		while( boardStatus == Board.IN_PROGRESS ) {
			tempState.togglePlayer();
			tempState.randomPlay();
			boardStatus = tempState.board.checkStatus();
		}

		return boardStatus;
	}
	
}