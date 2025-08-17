package mcts.montecarlo;

import CodinGame.printErr;
import Math.round;
import Std.int;
import haxe.Timer;
import mcts.tictactoe.Board;
import mcts.tictactoe.IBoard;
import mcts.tictactoe.Position;
import mcts.tree.Node;
import mcts.tree.NodePool;

class MonteCarloTreeSearch {
	
	public static inline var WIN_SCORE = 10;
	
	var rootNode:Node;
	final nodePool:NodePool;
	final statePool:StatePool;
	final responseTime:Float;

	public var level = 3;
	public var opponent:Int;
	var nodeCount = 0;
	var nodeDepth = 0;

	var startTime = 0.0;
	var endTime = 0.0;

	public function new( rootNode:Node, nodePool:NodePool, statePool:StatePool, responseTime:Float ) {
		this.rootNode = rootNode;
		this.nodePool = nodePool;
		this.statePool = statePool;
		this.responseTime = responseTime;
		
		rootNode.state.togglePlayer();
	}

	public function getNodeOfMove( p:Position ) {
		final childMoves = [for( child in rootNode.children ) child.state.board.move].join(",");
		// printErr( 'getNodeOfMove $p. child moves: $childMoves' );

		for( child in rootNode.children ) if( child.state.board.move == p ) {
			nodePool.recycle( rootNode );
			rootNode = child;
			// printErr( 'new rootNode from child node ${child.id}' );
			
			return rootNode;
		}

		// Node is not in children
		// create new node and perform move
		final newState = statePool.get( opponent, rootNode.state.board );
		final newNode = nodePool.get( newState );
		newNode.state.board.performMove( opponent, p );
		
		nodePool.recycle( rootNode );
		rootNode = newNode;
		// printErr( 'get new root node ${newNode.id} player ${rootNode.state.player}' );

		return rootNode;
	}

	public function findNextMove( player:Int ) {
		#if nodejs
		js.html.Console.profile();
		#end

		startTime = Timer.stamp();
		endTime = startTime + responseTime;

		nodeCount = 0;
		opponent = 3 - player;

		var loopTime = 0.0;
		var numLoops = 0;
		nodeDepth = 0;
		while( Timer.stamp() < endTime ) {
			final loopStartTime = Timer.stamp();
			// Phase 1 - Selection
			// final selectStart = Timer.stamp();
			final promisingNode = selectPromisingNode( rootNode );
			
			// if( Timer.stamp() > endTime ) printErr( 'after selectPromisingNode time ${round(( Timer.stamp() - selectStart ) * 1000 )}' );
			// printErr( 'Phase 1 - Selection time ${int(( Timer.stamp() - startTime ) * 1000 )}' );
			// Phase 2 - Expansion
			if( promisingNode.state.board.status == Board.IN_PROGRESS ) expandNode( promisingNode );
			// printErr( 'Phase 2 - Expansion time ${int(( Timer.stamp() - startTime ) * 1000 )}' );
			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.children.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();

			// final playoutStart = Timer.stamp();
			final playoutResult = simulateRandomPlayout( nodeToExplore );
			// if( Timer.stamp() > endTime ) printErr( 'after simulateRandomPlayout time ${round(( Timer.stamp() - playoutStart ) * 1000 )}ms' );
			// printErr( 'Phase 3 - Simulation time ${int(( Timer.stamp() - startTime ) * 1000 )}' );
			// Phase 4 - Update
			backPropagation( nodeToExplore, playoutResult );
			// printErr( 'Phase 4 - Update time ${int(( Timer.stamp() - startTime ) * 1000 )}' );

			loopTime = Timer.stamp() - loopStartTime;
			numLoops++;
		}

		if( rootNode.children.length == 0 ) throw 'Error: Node has not children.${rootNode.state.board}';

		final winnerNode = rootNode.getChildWithMaxScore();
		// printErr( 'winnerNode ${winnerNode.id}, player ${winnerNode.state.player}, children ${winnerNode.children.length}' );
		
		final recycleStart = Timer.stamp();
		
		// recycle nodes
		for( child in rootNode.children ) if( child != winnerNode ) nodePool.recycleBranch( child );
		nodePool.recycle( rootNode );
		rootNode = winnerNode;
		
		printErr( 'recycle time ${round(( Timer.stamp() - recycleStart ) * 1000 )}ms' );

		#if nodejs
		js.html.Console.profileEnd();
		#end
		
		printErr( 'player $player, $nodeCount nodes in ${round(( Timer.stamp() - startTime ) * 1000 )}ms   $numLoops loops, ${round( loopTime * 1000 )}ms' );
		// printErr( 'winnerNode state player ${winnerNode.state.player}\n${winnerNode.state.board}' );
		final poolNodeIds = [for( node in nodePool.pool ) node.id];
		final poolStateIds = [for( state in statePool.pool ) state.id];
		// printErr( 'pn: ${poolNodeIds.join(",")}\nps: ${poolStateIds.join(",")}' );
		// for( i in 0...poolNodeIds.length ) if( poolNodeIds[i] != poolStateIds[i] ) printErr( 'difference at $i: ${poolNodeIds[i]} != ${poolStateIds[i]}' );
		// printErr( 'nodePool length ${nodePool.length}\nstatePool length ${statePool.length}' );
		return winnerNode.state.board;
	}

	function selectPromisingNode( rootNode:Node ) {
		var node = rootNode;
		while( node.children.length != 0 ) {
			// if( Timer.stamp() > endTime ) {
			// 	printErr( 'break select ${round((Timer.stamp() - startTime ) * 1000)}' );
			// 	break;
			// }
			node = findBestNodeWithUCT( node );
		}
		
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
		// printErr( "expandNode" );
		final opponent = node.state.getOpponent();
		final possibleStates = node.state.getAllPossibleStates( statePool, opponent );
		// printErr( 'possibleStates ${possibleStates.length}: ' + [for( state in possibleStates ) state.id].join( ', ' ) );
		for( state in possibleStates ) {
			final newNode = nodePool.get( state );
			node.children.push( newNode );
			nodeCount++;
		}
		// printErr( "end expandNode" );
	}

	public static var startBoard:IBoard;

	function simulateRandomPlayout( node:Node ) {
		var boardStatus = node.state.board.status;
		
		if( boardStatus == opponent ) {
			node.parent.state.winScore = Integer.MIN_VALUE;
			return boardStatus;
		}

		final tempState = statePool.get( node.state.player, node.state.board );
		final tempNode = nodePool.get( tempState );
		startBoard = node.state.board;
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
		// statePool.recycle( tempState );
		nodePool.recycle( tempNode );
		
		return boardStatus;
	}
	
	function backPropagation( nodeToExplore:Node, playerNo:Int ) {
		var tempNode = nodeToExplore;
		while( tempNode != Node.NO_NODE ) {
			tempNode.state.incrementVisit();
			if( tempNode.state.player == playerNo ) tempNode.state.addScore( WIN_SCORE );
			tempNode = tempNode.parent;
		}
	}
}