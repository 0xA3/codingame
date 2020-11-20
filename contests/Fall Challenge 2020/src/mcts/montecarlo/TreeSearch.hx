package mcts.montecarlo;

import mcts.montecarlo.MonteCarloTreeSearch.ActionDeltaValue;
import game.data.Action;
import CodinGame.printErr;
import haxe.Timer;
import game.data.Board;
import mcts.tree.Node;
import mcts.tree.Tree;

class TreeSearch {
	
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
		final board = tree.rootNode.state.board;
		board.initActions();
		for( action in inputActions ) {
			board.addAction( action );
		}
	}

	public function findNextMove( playerNo = 1 ) {
		
		end = start + RESPONSE_TIME;

		
		// Phase 1 - Selection
		final promisingNode = tree.rootNode;
		// printErr( '$exploredNodes promisingNode ${promisingNode.displayNode()}' );
		
		// Phase 2 - Expansion
		if( promisingNode.state.checkStatus() != InProgress ) return tree.rootNode.state.board;
		
		expandNode( promisingNode );
		// printErr( tree.display());
		final childNodes = promisingNode.childArray;

		// Phase 3 - Simulation
		for( nodeToExplore in childNodes ) {
			nodeToExplore.nodeValue = getNodeValue( nodeToExplore );
		}

		childNodes.sort(( a, b ) -> {
			if( a.nodeValue < b.nodeValue ) return 1;
			if( a.nodeValue > b.nodeValue ) return -1;
			return 0;
		});
		
		printErr( tree.display());
			
		final winnerNode = childNodes[0];
		
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
				final score = me.score / board.maxScore / board.totalMoves;
				return score;
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
				
				var castNodeValue = 0.0;
				for( adv in potionDeltaValues ) {
					if( adv.deltaValue > castNodeValue ) castNodeValue = adv.deltaValue;
				}
		
				return castNodeValue / 10000;
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
