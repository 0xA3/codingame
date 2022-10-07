package ai;

import CodinGame.printErr;
import ai.Node.NO_NODE;
import data.State;
import sim.Simulator;

class Ai {
	
	public static final actions = ["WAIT", "SPEED", "SLOW", "JUMP", "UP", "DOWN"];
	
	final simulator:Simulator;

	public function new( simulator:Simulator ) {
		this.simulator = simulator;
	}

	public function process( state:State ) {
		final root = new Node( state, 0 );
		final actionId = search( root );
		
		return actions[actionId];
	}

	function search( root:Node ) {
		final frontier = new MaxPriorityQueue<Node>( sortNodes );
		frontier.insert( root );

		// var steps = 0;
		// while( steps++ < 100 && !frontier.isEmpty()) {
		while( !frontier.isEmpty()) {
			final current = frontier.delMax();
			
			// printErr( 'current $current  size ${frontier.size()}' );
			
			final state = current.state;
			// printErr( 'state.alive ${state.alive}  simulator.minSurvivingBikes ${simulator.minSurvivingBikes}' );
			if( state.alive >= simulator.minSurvivingBikes ) {
				// trace( 'finished ${simulator.finished( state.x )}' );
				if( simulator.finished( state.x )) return backtrack( current );
				
				for( id in 0...actions.length ) {
					final state = simulator.execute( current.state, id );
					final node = new Node( state, current.depth + 1, id, current );
					// printErr( 'new node $node' );
					frontier.insert( node );
				}
			}
		}
		throw 'Error: no solution found';
	}

	static function sortNodes( a:Node, b:Node ) {
		if( a.state.x < b.state.x ) return false;
		if( a.state.x > b.state.x ) return true;
		
		if( a.state.alive < b.state.alive ) return false;
		else return true;
	}

	function backtrack( endNode:Node ) {
		var node = endNode;
		var actionId = node.actionId;
		while( node.parent != NO_NODE ) {
			actionId = node.actionId;
			node = node.parent;
		}

		return actionId;
	}
}