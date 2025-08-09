package mcts.montecarlo;

import CodinGame.printErr;
import haxe.ds.GenericStack;
import mcts.tictactoe.IBoard;

class StatePool {
	
	final pool = new GenericStack<State>();
	public var length = 0;

	public function new() {	}

	public function get( player:Int, board:IBoard ) {
		if( pool.isEmpty() ) {
			final state = State.create( player, board );
			return state;
		
		} else {
			final state = pool.pop();
			state.isInPool = false;

			length--;
			
			return state;
		}
	}

	public function getCopy( state:State ) {
		return state.copy();
	}

	public function add( state:State ) {
		if( state.isInPool ) {
			printErr( 'State is already in pool' );
			return;
		}
		state.isInPool = true;
		pool.add( state );
		length++;
	}
}