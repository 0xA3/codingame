package ai;

import CodinGame.printErr;
import ai.Node.NO_NODE;
import data.State;
import sim.Simulator;

class Ai {
	
	public static final actions = ["WAIT", "SPEED", "SLOW", "JUMP", "UP", "DOWN"];
	
	final simulator:Simulator;
	final solutions:Array<Node> = [];
	
	public function new( simulator:Simulator ) {
		this.simulator = simulator;
	}

	public function process( state:State ) {
		final root = new Node( 0, 0, state );
		final actionIds = search( root );
		final actions = actionIds.map( actionId -> actions[actionId] );
		return actions;
	}

	function search( root:Node ) {
		final frontier = new MaxPriorityQueue<Node>( sortNodes );
		frontier.insert( root );

		var nodeId = 1;
		while( !frontier.isEmpty()) {
			final current = frontier.delMax();
			
			// printErr( 'current $current  size ${frontier.size()}' );
			
			final state = current.state;
			// printErr( 'state.alive ${state.alive}  simulator.minSurvivingBikes ${simulator.minSurvivingBikes}' );
			if( state.alive >= simulator.minSurvivingBikes ) {
				// trace( 'finished ${simulator.finished( state.x )}' );
				if( simulator.finished( state.x )) {
					solutions.push( current );
					printErr( 'solution with ${current.state.alive} alive: ${backtrack( current ).map( actionId -> actions[actionId]).join(" ")} ' );
					break;
					// if( state.alive == simulator.bikes ) break;
				} else {
					for( id in 0...actions.length ) {
						final state = simulator.execute( current.state, id );
						if( state != State.NO_STATE ) {
							final node = new Node( nodeId++, current.depth + 1, state, id, current );
							// printErr( 'new node $node' );
							frontier.insert( node );
						}
					}
				}
			}
		}
		if( solutions.length == 0 ) throw 'Error: no solution found';
		
		solutions.sort(( a, b ) -> b.state.alive - a.state.alive );
		return backtrack( solutions[0] );
	}

	static function sortNodes( a:Node, b:Node ) {
		if( a.state.x < b.state.x ) return false;
		if( a.state.x > b.state.x ) return true;
		
		if( a.state.alive < b.state.alive ) return false;
		else return true;
	}

	function backtrack( endNode:Node ) {
		var node = endNode;
		var actionIds = [];
		while( node.parent != NO_NODE ) {
			actionIds.push( node.actionId );
			node = node.parent;
		}
		actionIds.reverse();
		
		return actionIds;
	}
}