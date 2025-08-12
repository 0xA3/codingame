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
			final nextBoard = board.copy();
			final state = State.create( player, nextBoard );
			// printErr( 'create State ${state.id}' );
			return state;
		
		} else {
			final state = pool.pop();
			state.player = player;
			state.board.getContentFrom( board );
			// printErr( 'get State ${state.id}' );
			state.isInPool = false;

			length--;
			
			return state;
		}
	}

	public function recycle( state:State ) {
		if( state.isInPool ) {
			// printErr( 'State ${state.id} is already in pool' );
			printErr( 'State is already in pool' );
			return;
		}

		// printErr( 'return State ${state.id} to pool' );
		pool.add( state );
		state.isInPool = true;
		length++;
	}
}