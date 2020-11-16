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

	var moveNo = 0;

	public function new( tree:Tree ) {
		this.tree = tree;
	}

	public function findNextMove( playerNo:Int ) {
		
		final start = Timer.stamp();
		final end = start + RESPONSE_TIME;

		opponent = 3 - playerNo;

		var exploredNodes = 0;
		while( Timer.stamp() < end ) {
			// Phase 1 - Selection
			final promisingNode = selectPromisingNode( tree.rootNode );
			// Phase 2 - Expansion
			if( promisingNode.state.checkStatus() == Board.IN_PROGRESS ) expandNode( promisingNode, playerNo );

			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.childArray.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();

			final playoutResult = simulateRandomPlayout( nodeToExplore );
			
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
			
			exploredNodes++;
		}
		// if( playerNo == 1 ) printErr( 'exploredNodes $exploredNodes');

		final winnerNode = tree.rootNode.getChildWithMaxScore();
		tree.rootNode = winnerNode;
		
		moveNo++;
		return winnerNode.state.board;
	}

	function selectPromisingNode( rootNode:Node ) {
		var node = rootNode;
		while( node.childArray.length != 0 ) node = UCT.findBestNodeWithUCT( node );
		return node;
	}

	function expandNode( node:Node, playerNo:Int ) {
		final possibleStates = node.state.getAllPossibleStates();
		for( state in possibleStates ) {
			final newNode = new Node( state, [], node );
			newNode.state.playerNo = playerNo;
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
		final tempNode = node.clone();
		final tempState = tempNode.state;
		var boardStatus = tempState.checkStatus();

		if( boardStatus == opponent ) {
			tempNode.parent.state.winScore = Integer.MIN_VALUE;
			return boardStatus;
		}

		var playoutNo = 0;
		while( boardStatus == Board.IN_PROGRESS ) {
			tempState.togglePlayer();
			tempState.randomPlay();
			boardStatus = tempState.checkStatus();
			playoutNo++;
		}
		// printErr( 'random playouts $playoutNo' );

		return boardStatus;
	}
	
}