package mcts.montecarlo;

import CodinGame.printErr;
import Std.int;
import haxe.Timer;
import mcts.tictactoe.Board;
import mcts.tree.Node;
import mcts.tree.Tree;

class MonteCarloTreeSearch {
	
	public static inline var WIN_SCORE = 10;
	
	final tree:Tree;
	
	public var level = 3;
	public var opponent:Int;

	public function new( tree:Tree ) {
		this.tree = tree;
		tree.root.state.togglePlayer();
	}

	function getMillisForCurrentLevel() return 2 * ( level - 1 ) + 1;

	public function findNextMove( player:Int ) {
		final start = Timer.stamp();
		// final end = start + 0.019 * getMillisForCurrentLevel();
		final end = start + 0.09;
		// printErr( 'time ${int(( end - start ) * 1000 )}' );

		opponent = 3 - player;
		final rootNode = tree.root;

		while( Timer.stamp() < end ) {
			// Phase 1 - Selection
			final promisingNode = selectPromisingNode( rootNode );
			// printErr( 'Phase 1 - Selection time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 2 - Expansion
			if( promisingNode.state.board.status == Board.IN_PROGRESS ) expandNode( promisingNode );
			// printErr( 'Phase 2 - Expansion time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.children.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();

			final playoutResult = simulateRandomPlayout( nodeToExplore );
			// printErr( 'Phase 3 - Simulation time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
			// printErr( 'Phase 4 - Update time ${int(( Timer.stamp() - start ) * 1000 )}' );
		}
		final winnerNode = rootNode.getChildWithMaxScore();
		tree.root = winnerNode;
		// printErr( 'Player: $player WinnerNode player: ${winnerNode.state.player} time ${int(( Timer.stamp() - start ) * 1000 )}' );
		
		return winnerNode.state.board;
	}

	function selectPromisingNode( rootNode:Node ) {
		var node = rootNode;
		while( node.children.length != 0 ) node = UCT.findBestNodeWithUCT( node );
		
		return node;
	}

	function expandNode( node:Node ) {
		final possibleStates = node.state.getAllPossibleStates();
		for( state in possibleStates ) {
			final newNode = new Node( state, [], node );
			newNode.state.player = node.state.getOpponent();
			node.children.push( newNode );
		}
	}

	function backPropagation( nodeToExplore:Node, playerNo:Int ) {
		var tempNode = nodeToExplore;
		while( tempNode != null ) {
			tempNode.state.incrementVisit();
			if( tempNode.state.player == playerNo ) tempNode.state.addScore( WIN_SCORE );
			tempNode = tempNode.parent;
		}
	}

	function simulateRandomPlayout( node:Node ) {
		// printErr( 'simulateRandomPlayout' );
		final tempNode = Node.copy( node );
		final tempState = tempNode.state;
		var boardStatus = tempState.board.status;

		if( boardStatus == opponent ) {
			tempNode.parent.state.winScore = Integer.MIN_VALUE;
			return boardStatus;
		}

		while( boardStatus == Board.IN_PROGRESS ) {
			tempState.togglePlayer();
			tempState.randomPlay();
			boardStatus = tempState.board.status;
		}
		// printErr( 'end simulateRandomPlayout' );
		return boardStatus;
	}
}