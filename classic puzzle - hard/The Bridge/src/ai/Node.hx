package ai;

import data.State;

class Node {
	
	public static final NO_NODE = new Node({ speed: 0, x: 0, alive: 0, motorbikes: [] }, 0 );

	public final actionId:Int;
	public final depth:Int;
	public final state:State;
	public var parent = NO_NODE;

	public function new( state:State, depth:Int, actionId = -1, ?parent:Node ) {
		this.state = state;
		this.depth = depth;
		this.actionId = actionId;
		this.parent = parent == null ? NO_NODE : parent;
	}

	public function toString() return 'depth: $depth, actionId: $actionId, x: ${state.x}, speed: ${state.speed}, alive: ${state.alive}';
}