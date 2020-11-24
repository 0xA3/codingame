package mcts.montecarlo;

import game.data.Action;
import CodinGame.printErr;
import haxe.Timer;
import game.data.Board;
import mcts.tree.Node;
import mcts.tree.Tree;

class MonteCarloTreeSearch {
	
	public static inline var WIN_SCORE = 10;
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.95;
	
	final tree:Tree;
	
	public var level = 3;
	var start:Float;
	var end:Float;

	public function new( tree:Tree ) {
		this.tree = tree;
		start = Timer.stamp();
	}

	public function updateNode( inputActions:Map<Int, Action> ) {
		start = Timer.stamp();
		final childArray = tree.rootNode.childArray;
		final board = tree.rootNode.state.board;
		final boardActions = tree.rootNode.state.board.actions;
				
		// printErr( 'remove obsolete actions ${Timer.stamp() - start}' );
		// remove obsolete actions
		for( boardActionId in boardActions.keys()) {
			// remove action
			if( !inputActions.exists( boardActionId )) {
				board.removeAction( boardActionId );
				// remove node with action
				for( i in -childArray.length + 1...1 ) {
					final node = childArray[-i];
					final action = node.state.board.action;
					if( action != null && action.actionId == boardActionId ) childArray.remove( node );
				}
			}
		}

		// printErr( 'add new actions ${Timer.stamp() - start}' );
		// add new actions
		final newActions:Array<Action> = [];
		for( inputActionId in inputActions.keys()) {
			if( !boardActions.exists( inputActionId )) {
				final inputAction = inputActions[inputActionId];
				board.addAction( inputAction );
				newActions.push( inputAction );
			}
		}

		// add new nodes if there already are children of rootNode
		if( tree.rootNode.childArray.length > 0 ) {
			final rootState = tree.rootNode.state;
			final doableActions = newActions.filter( action -> action.checkDoable( rootState.board.me ));
			for( action in doableActions ) {
				final node = new Node( rootState.clone(), [], tree.rootNode );
				final board = node.state.board;
				
				board.action = action;
				board.totalMoves = tree.rootNode.state.board.totalMoves + 1;
				childArray.push( node );
				// printErr( 'add $inputActionId ${Timer.stamp() - start}' );
			}
		}
		// printErr( 'update complete ${Timer.stamp() - start}' );

	}

	public function findNextMove( playerNo = 1 ) {
		
		end = start + RESPONSE_TIME;

		// opponent = 3 - playerNo;

		var exploredNodes = 0;
		// while( Timer.stamp() < end ) {
		while( exploredNodes < 12 ) {
			// Phase 1 - Selection
			final promisingNode = selectPromisingNode( tree.rootNode );
			// printErr( '$exploredNodes promisingNode ${promisingNode.displayNode()}' );
			
			// Phase 2 - Expansion
			if( promisingNode.state.checkStatus() == InProgress ) expandNode( promisingNode );
			// printErr( tree.display());
			
			// Phase 3 - Simulation
			var nodeToExplore = promisingNode;
			if( promisingNode.childArray.length > 0 ) nodeToExplore = promisingNode.getRandomChildNode();
			
			// final playoutResult = simulateRandomPlayout( nodeToExplore );
			final nodeValue = getNodeValue( nodeToExplore );
			// trace( nodeValue );
			// printErr( 'playoutResult $playoutResult' );

			// Phase 4 - Update
			backPropagation( nodeToExplore, nodeValue );
			printErr( tree.display());
			
			exploredNodes++;
		}
		// printErr( 'exploredNodes $exploredNodes' );

		final winnerNode = tree.rootNode.childArray.length > 0 ? tree.rootNode.getChildWithMaxScore() : tree.rootNode;
		printErr( tree.display( 1 ));
		
		tree.rootNode = winnerNode;
		
		return winnerNode.state.board;
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
			node.childArray.push( newNode );
		}
	}

	function backPropagation( nodeToExplore:Node, nodeValue:Float ) {
		var tempNode = nodeToExplore;
		while( tempNode != null ) {
			tempNode.state.incrementVisit();
			trace( tempNode.nodeValue );
			tempNode.state.addScore( tempNode.nodeValue );
			tempNode = tempNode.parent;
		}
		// trace( 'winScore ${nodeToExplore.state.winScore}' );
	}

	function getNodeValue( node:Node ) {
		final board = node.state.board;
		final action = board.action;
		if( action == null ) return 0.0;

		final me = board.me;

		switch action.actionType {
			case Brew:
				// final score = me.score / board.maxScore / board.totalMoves;
				// trace( 'depth ${board.totalMoves} action ${action.actionId} score $score' );
				return 0.0;
			case Cast:
				final inventoryValue = board.me.getInventoryValue();
				final potionDeltaValues:Array<ActionDeltaValue> = [];
				for( action in board.actions ) {
					if( action.actionType == Brew ) {
						final deltaValue = action.potionValue - ( action.potionValue - inventoryValue );
						if( deltaValue >= 0 ) {
							potionDeltaValues.push({ action: action, deltaValue: deltaValue });
						}
					}
				}
		
				potionDeltaValues.sort((a, b) -> {
					if( a.deltaValue > b.deltaValue ) return 1;
					if( a.deltaValue < b.deltaValue ) return -1;
					return 0;
				});
				
				var nodeValue = 0.0;
				for( adv in potionDeltaValues ) {
					if( adv.deltaValue > nodeValue ) nodeValue = adv.deltaValue;
				}
		
				return nodeValue;
			case Learn: return 0.0;
			default: return 0.0;
		}


	}

	function simulateRandomPlayout( node:Node ) {
		final tempNode = node.clone();
		final tempState = tempNode.state;
		var boardStatus = tempState.checkStatus();

		// trace( '\nsimulatePlayout boardStatus $boardStatus' );
		switch boardStatus {
			case Win( 2, _ ):
				tempNode.parent.state.winScore = Integer.MIN_VALUE;
				return boardStatus;
			default: // no-op
		}
		var playoutSteps = 0;
		while( true ) {
			tempState.randomPlay();
			boardStatus = tempState.checkStatus();
			switch boardStatus {
				case InProgress: // printErr( 'playout $subScore' );
				default: break;
			}
			playoutSteps++;
		}
		// printErr( 'playoutSteps: $playoutSteps' );
		// printErr( 'me: ${tempNode.state.board.me.score}' );
		// printErr( 'opponent: ${tempNode.state.board.opponent.score}' );
		// printErr( 'boardStatus: $boardStatus' );

		return boardStatus;
	}

}

typedef ActionDeltaValue = {
	final action:Action;
	final deltaValue:Float;
}