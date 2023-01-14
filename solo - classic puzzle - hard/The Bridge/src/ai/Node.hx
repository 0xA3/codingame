package ai;

import data.State;

class Node {
	
	public static final NO_NODE = new Node( -1, 0, { speed: 0, x: 0, alive: 0, motorbikes: [] } );

	public final id:Int;
	public final depth:Int;
	public final state:State;
	public final actionId:Int;
	public var parent = NO_NODE;

	public function new( id:Int, depth:Int, state:State, actionId = -1, ?parent:Node ) {
		this.id = id;
		this.state = state;
		this.depth = depth;
		this.actionId = actionId;
		this.parent = parent == null ? NO_NODE : parent;
	}

	public function toString() return '$id depth: $depth, action: ${Ai.actions[actionId]}, x: ${state.x}, speed: ${state.speed}, alive: ${state.alive}';
}