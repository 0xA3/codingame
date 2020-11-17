package mcts.montecarlo;

import CodinGame.printErr;
import haxe.Timer;
import game.data.Board;
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
		// while( exploredNodes < 10 ) {
			// Phase 1 - Selection
			final promisingNode = selectPromisingNode( tree.rootNode );
			// Phase 2 - Expansion
			if( promisingNode.state.checkStatus() == InProgress ) expandNode( promisingNode );

			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.childArray.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();
			// trace( 'node to explore: ${nodeToExplore.state.board.action.actionId}' );
			final playoutResult = simulateRandomPlayout( nodeToExplore );
			
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
			
			exploredNodes++;
		}
		// printErr( 'player $playerNo exploredNodes $exploredNodes');

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

	function expandNode( node:Node ) {
		final possibleStates = node.state.getAllPossibleStates( node.state.getOpponent());
		for( state in possibleStates ) {
			final newNode = new Node( state, [], node );
			node.childArray.push( newNode );
		}
	}

	function backPropagation( nodeToExplore:Node, playoutResult:TBoard ) {
		var tempNode = nodeToExplore;
		while( tempNode != null ) {
			tempNode.state.incrementVisit();
			switch playoutResult {
				case Win( 1, score ): tempNode.state.addScore( score );
				default: //no-op;
			}
			tempNode = tempNode.parent;
		}
		// trace( 'winScore ${nodeToExplore.state.winScore}' );
	}

	function simulateRandomPlayout( node:Node ) {
		// trace( 'node state ${node.state}' );
		final tempNode = node.clone();
		final tempState = tempNode.state;
		// trace( 'tempState $tempState' );
		var boardStatus = tempState.checkStatus();
		// trace( 'boardStatus $boardStatus' );

		switch boardStatus {
			case Win( 2, _ ):
				tempNode.parent.state.winScore = Integer.MIN_VALUE;
				return boardStatus;
			default: // no-op
		}
		var playoutSteps = 0;
		while( boardStatus == InProgress ) {
			tempState.togglePlayer();
			tempState.randomPlay();
			boardStatus = tempState.checkStatus();
			playoutSteps++;
		}
		// printErr( 'playoutSteps: $playoutSteps' );
		// printErr( 'me: ${tempNode.state.board.me.score}' );
		// printErr( 'opponent: ${tempNode.state.board.opponent.score}' );
		// printErr( 'boardStatus: $boardStatus' );

		return boardStatus;
	}
	
}