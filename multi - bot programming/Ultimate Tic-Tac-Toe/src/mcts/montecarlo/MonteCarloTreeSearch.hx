package mcts.montecarlo;

import CodinGame.printErr;
import Math.round;
import haxe.Timer;
import mcts.tictactoe.Board;
import mcts.tree.Node;
import mcts.tree.Tree;

class MonteCarloTreeSearch {
	
	public static inline var WIN_SCORE = 10;
	
	final tree:Tree;
	final responseTime:Float;

	public var level = 3;
	public var opponent:Int;
	var nodeCount = 0;
	var nodeDepth = 0;

	var startTime = 0.0;
	var endTime = 0.0;

	public function new( tree:Tree, responseTime:Float ) {
		this.tree = tree;
		this.responseTime = responseTime;

		tree.root.state.togglePlayer();
	}

	// function getMillisForCurrentLevel() return 2 * ( level - 1 ) + 1;

	public function findNextMove( player:Int ) {
		#if nodejs
		js.html.Console.profile();
		#end

		startTime = Timer.stamp();
		// final end = start + 0.019 * getMillisForCurrentLevel();
		
		endTime = startTime + responseTime;

		nodeCount = 0;
		opponent = 3 - player;
		final rootNode = tree.root;

		var loopTime = 0.0;
		var numLoops = 0;
		nodeDepth = 0;
		while( Timer.stamp() < endTime ) {
			final loopStartTime = Timer.stamp();
			// Phase 1 - Selection
			final selectStart = Timer.stamp();
			final promisingNode = selectPromisingNode( rootNode );
			if( Timer.stamp() > endTime ) printErr( 'after selectPromisingNode time ${round(( Timer.stamp() - selectStart ) * 1000 )}' );
			// printErr( 'Phase 1 - Selection time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 2 - Expansion
			
			if( promisingNode.state.board.status == Board.IN_PROGRESS ) expandNode( promisingNode );
			// printErr( 'Phase 2 - Expansion time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.children.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();

			final playoutStart = Timer.stamp();
			final playoutResult = simulateRandomPlayout( nodeToExplore );
			if( Timer.stamp() > endTime ) printErr( 'after simulateRandomPlayout time ${round(( Timer.stamp() - playoutStart ) * 1000 )}ms' );
			// printErr( 'Phase 3 - Simulation time ${int(( Timer.stamp() - start ) * 1000 )}' );
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
			// printErr( 'Phase 4 - Update time ${int(( Timer.stamp() - start ) * 1000 )}' );

			loopTime = Timer.stamp() - loopStartTime;
			numLoops++;
		}

		if( rootNode.children.length == 0 ) {
			printErr( 'Error: Node has not children.${rootNode.state.board}' );
			return rootNode.state.board;
		}

		final winnerNode = rootNode.getChildWithMaxScore();
		tree.root = winnerNode;
		
		#if nodejs
		js.html.Console.profileEnd();
		#end
		
		printErr( 'player $player, $nodeCount nodes in ${round(( Timer.stamp() - startTime ) * 1000 )}ms   maxDepth $nodeDepth     $numLoops loops, ${round( loopTime * 1000 )}ms' );
		
		return winnerNode.state.board;
	}

	function selectPromisingNode( rootNode:Node ) {
		var node = rootNode;
		var tempNodeDepth = 0;
		while( node.children.length != 0 ) {
			// if( Timer.stamp() > endTime ) {
			// 	printErr( 'break select ${round((Timer.stamp() - startTime ) * 1000)}' );
			// 	break;
			// }
			node = findBestNodeWithUCT( node );
			tempNodeDepth++;
		}
		
		if( tempNodeDepth > nodeDepth ) nodeDepth = tempNodeDepth;

		return node;
	}

	extern inline function findBestNodeWithUCT( node:Node ) {
		// if( node.children.length == 0 ) throw "Error: childArray length is 0";
		
		final parentVisit = node.state.visitCount;
		node.children.sort(( a, b ) -> {
			final aUct = uctValue( parentVisit, a.state.winScore, a.state.visitCount );
			final bUct = uctValue( parentVisit, b.state.winScore, b.state.visitCount );
			
			if( aUct < bUct ) return 1;
			if( aUct > bUct ) return -1;
			return 0;
		});
		// for( childNode in node.childArray ) trace( '$childNode UTC: ${uctValue( parentVisit, childNode.state.winScore, childNode.state.visitCount )}' );
		return node.children[0];
	}
	
	extern inline function uctValue( totalVisit:Int, nodeWinScore:Float, nodeVisit:Int ):Float {
		return nodeVisit == 0 ? Integer.MAX_VALUE : nodeWinScore / nodeVisit + 1.41 * Math.sqrt( Math.log( totalVisit ) / nodeVisit );
	}

	function expandNode( node:Node ) {
		final possibleStates = node.state.getAllPossibleStates();
		for( state in possibleStates ) {
			final newNode = new Node( state, [], node );
			newNode.state.player = node.state.getOpponent();
			node.children.push( newNode );
			nodeCount++;
		}
	}

	function simulateRandomPlayout( node:Node ) {
		final tempNode = Node.copy( node );
		final tempState = tempNode.state;
		var boardStatus = tempState.board.status;

		if( boardStatus == opponent ) {
			tempNode.parent.state.winScore = Integer.MIN_VALUE;
			return boardStatus;
		}

		// var previousTime = 0.0;
		while( boardStatus == Board.IN_PROGRESS ) {
			final currentTime = Timer.stamp();
			// if( currentTime > endTime ) {
			// 	printErr( 'break random playout ${round((currentTime - startTime ) * 1000)} (previousTime: ${round(previousTime * 1000)})' );
			// 	break;
			// }
			// previousTime = currentTime - startTime;
			tempState.togglePlayer();
			tempState.randomPlay();
			boardStatus = tempState.board.status;
		}
		
		return boardStatus;
	}
	
	function backPropagation( nodeToExplore:Node, playerNo:Int ) {
		var tempNode = nodeToExplore;
		while( tempNode != null ) {
			tempNode.state.incrementVisit();
			if( tempNode.state.player == playerNo ) tempNode.state.addScore( WIN_SCORE );
			tempNode = tempNode.parent;
		}
	}
}